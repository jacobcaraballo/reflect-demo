//
//  MDNSBrowser.swift
//  mDNS-exampe
//
//  Created by Jacob Caraballo on 1/1/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation

class MDNSBrowser: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
	
	let type: String
	let didUpdateServices: ([MDNSService]) -> ()
	var browser = NetServiceBrowser()
	var serviceList = [NetService]()
	var mdnsList = [MDNSService]()
	
	init(type: String, handler: @escaping ([MDNSService]) -> ()){
		self.type = type
		self.didUpdateServices = handler
		super.init()
		self.browser.includesPeerToPeer = true
		self.browser.delegate = self
	}
	
	func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
		print("mDNS browsing commencing...")
	}
	
	func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
		serviceList.append(service)
		print("Found: \(service)")
		if !moreComing {
			update()
		}
	}
	
	func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
		print("Search was not successful. Error code: \(String(describing: errorDict[NetService.errorCode]))")
		restart()
	}
	
	func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
		print("Updated TXT Record: \(data)")
	}
	
	func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
		
		if let serviceIndex = serviceList.firstIndex(of: service) {
			serviceList.remove(at: serviceIndex)
		}
		
		let subArray = mdnsList.filter({$0.service == service})
		for item in subArray {
			if let itemIndex = mdnsList.firstIndex(of: item) {
				mdnsList.remove(at: itemIndex)
			}
		}
		
		didUpdateServices(mdnsList)
		
		print("Became unavailable: \(service)")
		if !moreComing {
			update()
		}
	}
	
	func update() {
		for service in serviceList {
			service.delegate = self
			service.resolve(withTimeout: 5)
		}
	}
	
	func getAddress(from data: Data) -> Any? {
		
		let address = data.withUnsafeBytes { (_ bytes: UnsafePointer<sockaddr>) in
			bytes.withMemoryRebound(to: sockaddr_in.self, capacity: 1) {
				$0.pointee
			}
		}
		
		switch address.sin_family {
		case __uint8_t(AF_INET):
			return address
		case __uint8_t(AF_INET6):
			return data.withUnsafeBytes { (_ bytes: UnsafePointer<sockaddr>) in
				bytes.withMemoryRebound(to: sockaddr_in6.self, capacity: 1) {
					$0.pointee
				}
			}
		default:
			break
		}
		
		return nil
		
	}
	
	func netServiceDidResolveAddress(_ sender: NetService) {
		
		guard let addresses = sender.addresses else { return }
		
		for addressBytes in addresses {
			
			var ipStringRaw : UnsafePointer<Int8>?
			let ipStringBuffer = UnsafeMutablePointer<Int8>.allocate(capacity: Int(INET6_ADDRSTRLEN))
			
			guard let address = getAddress(from: addressBytes) else { return }
			if let address = address as? sockaddr_in {
				var addr = address.sin_addr
				ipStringRaw = inet_ntop(
					Int32(address.sin_family),
					&addr,
					ipStringBuffer,
					__uint32_t(INET6_ADDRSTRLEN)
				)
			} else if let address = address as? sockaddr_in6 {
				var addr  = address.sin6_addr
				ipStringRaw = inet_ntop(
					Int32(address.sin6_family),
					&addr,
					ipStringBuffer,
					__uint32_t(INET6_ADDRSTRLEN)
				)
			}
			
			if let ipStringRaw = ipStringRaw {
				let ip = String(cString: ipStringRaw)
				print("[NEW] \(sender.name)(\(sender.type)) - \(ip)")
				mdnsList.append(MDNSService(service: sender, ip: ip))
				didUpdateServices(mdnsList)
			}
			
			ipStringBuffer.deallocate()
			
		}
		
		
	}
	
	func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
		print("\(sender.name) did not resolve: \(errorDict[NetService.errorCode]!)")
	}
	
	func start() {
		browser.searchForServices(ofType: type, inDomain: "local.")
	}
	
	func restart() {
		stop()
		start()
	}
	
	func stop() {
		browser.stop()
		for service in serviceList {
			service.stop()
		}
		serviceList.removeAll()
		mdnsList.removeAll()
		MDNSServicesDiscovered.removeAll()
		CurrentlyConnectedService = nil
	}
	
}
