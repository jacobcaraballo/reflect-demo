//
//  KeyboardService.swift
//  Money
//
//  Created by Jacob Caraballo on 6/11/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class KeyboardService {
	
	enum SizeType {
		case `default`, secure, email, decimal
	}
	
	static var shared = KeyboardService()
	static var height: CGFloat {
		return height(forType: .default)
	}
	static var width: CGFloat {
		return width(forType: .default)
	}
	static var secureHeight: CGFloat {
		return height(forType: .secure)
	}
	static var emailHeight: CGFloat {
		return height(forType: .email)
	}
	
	class func height(forType type: SizeType) -> CGFloat {
		return shared.sizes[type]?.height ?? 0
	}
	
	class func width(forType type: SizeType) -> CGFloat {
		return shared.sizes[type]?.width ?? 0
	}
	
	var setupCompletion: (() -> ())?
	
	private var sizes = [SizeType: CGRect]()
	private var observerRemoved = false
	
	private var textField: UITextField!
	
	init() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	
	deinit {
		if !observerRemoved {
			NotificationCenter.default.removeObserver(self)
		}
	}
	
	class func setup(inView view: UIView) {
		
		shared.setup(inView: view, type: .default, isSecure: false) {
			NotificationCenter.default.removeObserver(shared)
			shared.observerRemoved = true
			shared.setupCompletion = nil
		}
		
	}
	
	private func setup(inView view: UIView, type: UIKeyboardType, isSecure: Bool, completion: (() -> ())?) {
		
		var sizeType = SizeType.default
		if isSecure {
			sizeType = .secure
		} else if type == .default {
			sizeType = .default
		} else if type == .decimalPad {
			sizeType = .decimal
		} else if type == .emailAddress {
			sizeType = .email
		}
		
		if sizes[sizeType] == nil || sizes[sizeType] == .zero {
			textField = UITextField()
			textField.keyboardType = type
			textField.isSecureTextEntry = isSecure
			view.addSubview(textField)
			setupCompletion = completion
			textField.becomeFirstResponder()
		}
		
	}
	
	@objc func keyboardWillShow(_ note: Notification) {
		
		guard let info = note.userInfo, let value = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		
		
		let size = value.cgRectValue
		if textField.isSecureTextEntry {
			sizes[.secure] = size
		} else if textField.keyboardType == .default {
			sizes[.default] = size
		} else if textField.keyboardType == .decimalPad {
			sizes[.decimal] = size
		} else if textField.keyboardType == .emailAddress {
			sizes[.email] = size
		}
		
		
		textField.resignFirstResponder()
		textField.removeFromSuperview()
		textField = nil
		
		setupCompletion?()
		
	}
	
}
