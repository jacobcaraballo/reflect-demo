//
//  LoginView.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/2/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
	
	let usernameField = UITextField()
	let passwordField = UITextField()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init() {
		super.init(frame: .zero)
		
		setupUsernameField()
		setupPasswordField()
		
	}
	
	func setupUsernameField() {
		
		usernameField.translatesAutoresizingMaskIntoConstraints = false
		
		
	}
	
	func setupPasswordField() {
		
		passwordField.translatesAutoresizingMaskIntoConstraints = false
		
	}
	
}
