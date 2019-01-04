//
//  CategoryCell.swift
//  mirror-workout-demo
//
//  Created by Jacob Caraballo on 12/31/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UITableViewCell {
	
	
	private let backgroundImageView = UIImageView()
	var imageName: String? {
		
		didSet {
			if let image = imageName {
				backgroundImageView.image = UIImage(named: image)
			} else {
				backgroundImageView.image = nil
			}
		}
		
	}
	
	private var label = UILabel()
	var title: String = "Sizing Title" {
		didSet {
			label.text = title
			label.sizeToFit()
		}
	}
	
	private var backgroundShadow = UIView()
	
	
	// selection separators
	var topSelectionSeparator = UIView()
	var bottomSelectionSeparator = UIView()
	
	
	
	// normal and expanded font size
	private var fontSize: CGFloat = 40
	private var expandedFontSize: CGFloat = 60
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		
		setupImageView()
		setupBackgroundShadow()
		setupTextLabel()
		setupSelectionSeparators()
		
	}
	
	func toggle(expanded: Bool, animated: Bool) {
		let scale: CGFloat = expanded ? 1.3 : 1
		let alpha: CGFloat = expanded ? 1 : 0
		let anim = UIViewPropertyAnimator(duration: animated ? 0.25 : 0, curve: .linear) {
			self.label.transform = CGAffineTransform(scaleX: scale, y: scale)
//			self.topSelectionSeparator.alpha = alpha
//			self.bottomSelectionSeparator.alpha = alpha
			self.backgroundShadow.alpha = 1 - alpha
		}
		anim.startAnimation()
	}
	
	func setupTextLabel() {
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: fontSize)
		label.text = title
		label.sizeToFit()
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowRadius = 10
		label.layer.shadowOffset = .zero
		label.layer.shadowOpacity = 0.4
		contentView.addSubview(label)
		
		NSLayoutConstraint.activate([
			
			label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			
			])
		
	}
	
	func setupBackgroundShadow() {
		
		backgroundShadow.translatesAutoresizingMaskIntoConstraints = false
		backgroundShadow.backgroundColor = UIColor(white: 0, alpha: 0.5)
		contentView.addSubview(backgroundShadow)
		
		NSLayoutConstraint.activate([
			
			backgroundShadow.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			backgroundShadow.heightAnchor.constraint(equalTo: contentView.heightAnchor),
			backgroundShadow.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			backgroundShadow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			
			])
		
	}
	
	func setupImageView() {
		
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		contentView.addSubview(backgroundImageView)
		
		NSLayoutConstraint.activate([
			
			backgroundImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
			backgroundImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			
			])
		
	}
	
	func setupSelectionSeparators() {
		
		topSelectionSeparator.translatesAutoresizingMaskIntoConstraints = false
		topSelectionSeparator.backgroundColor = .red
		topSelectionSeparator.alpha = 0
		contentView.addSubview(topSelectionSeparator)
		
		bottomSelectionSeparator.translatesAutoresizingMaskIntoConstraints = false
		bottomSelectionSeparator.backgroundColor = .red
//		bottomSelectionSeparator.alpha = 0
		contentView.addSubview(bottomSelectionSeparator)
		
		
		
		NSLayoutConstraint.activate([
			
			topSelectionSeparator.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			topSelectionSeparator.heightAnchor.constraint(equalToConstant: 1),
			topSelectionSeparator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			topSelectionSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
			
			bottomSelectionSeparator.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			bottomSelectionSeparator.heightAnchor.constraint(equalToConstant: 1),
			bottomSelectionSeparator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			bottomSelectionSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			
			])
		
	}
	
}
