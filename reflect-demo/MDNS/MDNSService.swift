//
//  MDNSService.swift
//  mDNS-exampe
//
//  Created by Jacob Caraballo on 1/1/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation

class MDNSService {
	
	let service: NetService
	let ip: String
	var port: Int {
		return service.port
	}
	var name: String {
		return service.name
	}
	
	var input: InputStream!
	var output: OutputStream!
	
	init(service: NetService, ip:String) {
		self.service = service
		self.ip = ip
	}
	
	func connect() {
		guard output == nil && service.getInputStream(&input, outputStream: &output) else { return }
		input.open()
		output.open()
	}
	
	func disconnect() {
		input?.close()
		output?.close()
		
		input = nil
		output = nil
	}
	
	func write(string: String) {
		guard let data = string.data(using: String.Encoding.utf8) else { return }
		write(data: data)
	}
	
	func write(data: Data) {
		let result = output.write([UInt8](data), maxLength: data.count)
		print(result)
	}
	
	deinit {
		disconnect()
	}
	
}

extension MDNSService: Equatable {
	
	static func == (lhs: MDNSService, rhs: MDNSService) -> Bool {
		return (lhs.service == rhs.service) && (lhs.ip == rhs.ip)
	}
	
}
