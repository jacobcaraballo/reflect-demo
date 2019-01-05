//
//  Extensions.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/2/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
	func image(withColor color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		color.setFill()
		
		let context = UIGraphicsGetCurrentContext()
		context?.translateBy(x: 0, y: self.size.height)
		context?.scaleBy(x: 1.0, y: -1.0)
		context?.setBlendMode(CGBlendMode.normal)
		
		let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
		context?.clip(to: rect, mask: self.cgImage!)
		context?.fill(rect)
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage!
	}
}

extension UIView {
	
	func setScale(scale: CGFloat) {
		transform = CGAffineTransform(scaleX: scale, y: scale)
	}
	
	func setRotation(angle: CGFloat) {
		transform = CGAffineTransform(rotationAngle: angle)
	}
	
}

extension UIEdgeInsets {
	
	var horizontal: CGFloat {
		return left
	}
	
	var vertical: CGFloat {
		return top
	}
	
	init(horizontal: CGFloat, vertical: CGFloat) {
		self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
	}
	
}

