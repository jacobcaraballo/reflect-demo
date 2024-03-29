//
//  AppDelegate.swift
//  mirror-workout-demo
//
//  Created by Jacob Caraballo on 12/31/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import UIKit

var MDNSServicesDiscovered = [MDNSService]()
var CurrentlyConnectedService: MDNSService?
var MDNSReflectBrowser: MDNSBrowser!

var safeInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		if let window = window {
			KeyboardService.setup(inView: window)
			safeInsets.top = window.safeAreaInsets.top
			safeInsets.bottom = window.safeAreaInsets.bottom
		}
		
		MDNSReflectBrowser = MDNSBrowser(type: "_RainbowRoad._tcp.") { services in
			MDNSServicesDiscovered = services
			self.updateConnectedMDNSService()
		}
		
		return true
	}
	
	private func updateConnectedMDNSService() {
		
		// if our service is already connected, return
		if let connectedService = CurrentlyConnectedService, MDNSServicesDiscovered.contains(connectedService) { return }
		
		
		// if there are no services found, disconnect and nullify our connected service
		guard MDNSServicesDiscovered.count != 0 else {
			CurrentlyConnectedService?.disconnect()
			CurrentlyConnectedService = nil
			return
		}
		
		
		// connect the service
		CurrentlyConnectedService = MDNSServicesDiscovered[0]
		CurrentlyConnectedService?.connect()
		
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

