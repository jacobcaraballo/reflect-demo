//
//  LoginView.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/2/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIViewController {
	
	var continueButton: UIButton!
	
	// title attributes
	let logo = UIImageView()
	let logoHeightBig: CGFloat = 100
	let logoHeightSmall: CGFloat = 90
	
	
	// animatable constraints
	var logoHeightConstraint: NSLayoutConstraint!
	var continueButtonBottomConstraint: NSLayoutConstraint!
	var usernameTopConstraint: NSLayoutConstraint!
	var logoTopConstraint: NSLayoutConstraint!
	
	
	// font sizes
	let fieldLabelFontSize: CGFloat = 12
	
	
	// field variables
	let usernameLabel = UILabel()
	let passwordLabel = UILabel()
	
	let usernameFieldView = UIView()
	let passwordFieldView = UIView()
	
	let usernameField = UITextField()
	let passwordField = UITextField()
	
	
	// field attributes
	var logoTopPadding: CGFloat {
		return UIApplication.shared.statusBarFrame.height + fieldPadding.vertical + 30
	}
	var logoTopPaddingCompact: CGFloat {
		return UIApplication.shared.statusBarFrame.height + fieldPadding.vertical
	}
	let fieldHeight: CGFloat = 40
	let logoToFieldPadding: CGFloat = 70
	let logoToFieldPaddingCompact: CGFloat = 20
	let fieldPadding = UIEdgeInsets(horizontal: 30, vertical: 25)
	let fieldRadius: CGFloat = 20
	let fieldPlaceholderColor = UIColor(white: 1, alpha: 0.4)
	
	
	// keeps track of the labels current state (compact or expanded)
	var labelsAreCompact = false
	
	
	// handler for authentication
	var didAuthenticate: (() -> ())?
	
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(white: 0.1, alpha: 1)
		
		setupLogo()
		setupUsernameField()
		setupPasswordField()
		setupContinueButton()
	}
	
	private func setupLogo() {
		
		logo.translatesAutoresizingMaskIntoConstraints = false
		logo.contentMode = .scaleAspectFit
		logo.image = UIImage(named: "logo2")
		view.addSubview(logo)
		
		logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: logoHeightBig)
		logoTopConstraint = logo.topAnchor.constraint(equalTo: view.topAnchor, constant: logoTopPadding)
		
		NSLayoutConstraint.activate([
			
			logo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(fieldPadding.horizontal * 2)),
			logoHeightConstraint,
			logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoTopConstraint
			
			])
		
	}
	
	private func setupUsernameField() {
		
		// setup the field view
		usernameFieldView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(usernameFieldView)
		
		
		// setup the label for the field
		usernameLabel.translatesAutoresizingMaskIntoConstraints = false
		usernameLabel.font = UIFont.systemFont(ofSize: fieldLabelFontSize)
		usernameLabel.text = "EMAIL"
		usernameLabel.textColor = .white
		usernameLabel.sizeToFit()
		usernameFieldView.addSubview(usernameLabel)
		
		
		// setup the field
		usernameField.translatesAutoresizingMaskIntoConstraints = false
		usernameField.attributedPlaceholder = NSAttributedString(string: "jane@fonda.com", attributes: [.foregroundColor: fieldPlaceholderColor])
		usernameField.textColor = .white
		usernameField.keyboardAppearance = .dark
		usernameField.keyboardType = .emailAddress
		usernameField.returnKeyType = .next
		usernameField.delegate = self
		usernameField.tintColor = .white
		usernameField.inputAccessoryView = createContinueButton()
		usernameField.inputAccessoryView!.heightAnchor.constraint(equalToConstant: 55).isActive = true
		usernameFieldView.addSubview(usernameField)
		
		// create bottom border under the field
		let bottomBorder = UIView()
		bottomBorder.translatesAutoresizingMaskIntoConstraints = false
		bottomBorder.backgroundColor = .red
		usernameFieldView.addSubview(bottomBorder)
		
		usernameTopConstraint = usernameFieldView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: logoToFieldPadding)
		
		NSLayoutConstraint.activate([
			
			usernameFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(fieldPadding.horizontal * 2)),
			usernameFieldView.heightAnchor.constraint(equalToConstant: fieldHeight + usernameLabel.frame.height),
			usernameFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			usernameTopConstraint,
			
			usernameLabel.topAnchor.constraint(equalTo: usernameFieldView.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: usernameFieldView.leadingAnchor),
			
			usernameField.widthAnchor.constraint(equalTo: usernameFieldView.widthAnchor),
			usernameField.heightAnchor.constraint(equalToConstant: fieldHeight),
			usernameField.centerXAnchor.constraint(equalTo: usernameFieldView.centerXAnchor),
			usernameField.bottomAnchor.constraint(equalTo: usernameFieldView.bottomAnchor),
			
			bottomBorder.widthAnchor.constraint(equalTo: usernameFieldView.widthAnchor),
			bottomBorder.heightAnchor.constraint(equalToConstant: 1),
			bottomBorder.bottomAnchor.constraint(equalTo: usernameFieldView.bottomAnchor),
			bottomBorder.centerXAnchor.constraint(equalTo: usernameFieldView.centerXAnchor)
			
			])
		
	}
	
	private func setupPasswordField() {
		
		// setup field view
		passwordFieldView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(passwordFieldView)
		
		
		// setup the label for the field
		passwordLabel.translatesAutoresizingMaskIntoConstraints = false
		passwordLabel.font = UIFont.systemFont(ofSize: fieldLabelFontSize)
		passwordLabel.text = "PASSWORD"
		passwordLabel.textColor = .white
		passwordLabel.sizeToFit()
		passwordFieldView.addSubview(passwordLabel)
		
		
		// setup the field
		passwordField.translatesAutoresizingMaskIntoConstraints = false
		passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [.foregroundColor: fieldPlaceholderColor])
		passwordField.textColor = .white
		passwordField.keyboardAppearance = .dark
		passwordField.returnKeyType = .done
		passwordField.delegate = self
		passwordField.tintColor = .white
		passwordField.isSecureTextEntry = true
		passwordField.inputAccessoryView = createContinueButton()
		passwordField.inputAccessoryView!.heightAnchor.constraint(equalToConstant: 55).isActive = true
		passwordFieldView.addSubview(passwordField)
		
		
		// create bottom border
		let bottomBorder = UIView()
		bottomBorder.translatesAutoresizingMaskIntoConstraints = false
		bottomBorder.backgroundColor = .red
		passwordFieldView.addSubview(bottomBorder)
		
		NSLayoutConstraint.activate([
			
			passwordFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(fieldPadding.horizontal * 2)),
			passwordFieldView.heightAnchor.constraint(equalToConstant: fieldHeight + passwordLabel.frame.height),
			passwordFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			passwordFieldView.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: fieldPadding.vertical),
			
			passwordLabel.topAnchor.constraint(equalTo: passwordFieldView.topAnchor),
			passwordLabel.leadingAnchor.constraint(equalTo: passwordFieldView.leadingAnchor),
			
			passwordField.widthAnchor.constraint(equalTo: passwordFieldView.widthAnchor),
			passwordField.heightAnchor.constraint(equalToConstant: fieldHeight),
			passwordField.centerXAnchor.constraint(equalTo: passwordFieldView.centerXAnchor),
			passwordField.bottomAnchor.constraint(equalTo: passwordFieldView.bottomAnchor),
			
			bottomBorder.widthAnchor.constraint(equalTo: passwordFieldView.widthAnchor),
			bottomBorder.heightAnchor.constraint(equalToConstant: 1),
			bottomBorder.bottomAnchor.constraint(equalTo: passwordFieldView.bottomAnchor),
			bottomBorder.centerXAnchor.constraint(equalTo: passwordFieldView.centerXAnchor)
			
			])
		
	}
	
	private func createContinueButton() -> UIButton {
		let continueButton = UIButton()
		continueButton.translatesAutoresizingMaskIntoConstraints = false
		continueButton.backgroundColor = UIColor(white: 0.15, alpha: 1)
		continueButton.setTitle("CONTINUE", for: .normal)
		continueButton.setTitleColor(.white, for: .normal)
		continueButton.setTitleColor(UIColor(white: 0.5, alpha: 1), for: .highlighted)
		continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
		return continueButton
	}
	
	private func setupContinueButton() {
		
		continueButton = createContinueButton()
		view.addSubview(continueButton)
		
		continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeInsets.bottom)
		NSLayoutConstraint.activate([
			
			continueButton.widthAnchor.constraint(equalTo: view.widthAnchor),
			continueButton.heightAnchor.constraint(equalToConstant: 55),
			continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			continueButtonBottomConstraint
			
			])
		
		
		// add a bottom padding for iPhone X
		if safeInsets.bottom != 0 {
			
			let bottomPaddingView = UIView()
			bottomPaddingView.backgroundColor = continueButton.backgroundColor
			bottomPaddingView.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(bottomPaddingView)
			
			NSLayoutConstraint.activate([
				
				bottomPaddingView.widthAnchor.constraint(equalTo: view.widthAnchor),
				bottomPaddingView.heightAnchor.constraint(equalToConstant: safeInsets.bottom),
				bottomPaddingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				bottomPaddingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
				
				])
			
		}
		
	}
	
	@objc func continueButtonPressed() -> Bool {
		guard let textField: UITextField =
			usernameField.isFirstResponder ? usernameField :
			passwordField.isFirstResponder ? passwordField : nil
			else { return false }
		guard let text = textField.text, !text.isEmpty else { return false }
		
		if textField == usernameField {
			guard text.contains("@") else { return false }
			passwordField.becomeFirstResponder()
		} else {
			dismiss()
			textField.resignFirstResponder()
		}
		
		return true
	}
	
	private func verifyCredentials() -> Bool {
		guard let username = usernameField.text, !username.isEmpty else { return false }
		guard let password = passwordField.text, !password.isEmpty else { return false }
		
		return true
	}
	
	private func dismiss() {
		guard verifyCredentials() else { return }
		
		didAuthenticate?()
		dismiss(animated: true, completion: nil)
		
	}
	
}


extension LoginView: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return continueButtonPressed()
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		guard !labelsAreCompact else { return true }
		
		labelsAreCompact = true
		logoHeightConstraint.constant = logoHeightSmall
		usernameTopConstraint.constant = logoToFieldPaddingCompact
		logoTopConstraint.constant = logoTopPaddingCompact
		
		let anim = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
			self.view.layoutIfNeeded()
		}

		anim.startAnimation()
		
		return true
	}
	
}
