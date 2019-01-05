//
//  VideoCell.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 12/31/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: UITableViewCell {
	
	private let thumbImageView = UIImageView()
	var thumbnail: String? {
		
		didSet {
			if let image = thumbnail {
				thumbImageView.image = UIImage(named: image)
			} else {
				thumbImageView.image = nil
			}
		}
		
	}
	
	private let titleView = UIView()
	private let instructorNameLabel = UILabel()
	private let titleLabel = UILabel()
	private let leftBarView = UIView()
	private let playButtonView = UIImageView()
	private let padding: CGFloat = 20
	private var gradientView: UIView!
	
	private var bottomSeparator = UIView()
	var showsBottomSeparator: Bool = true {
		didSet {
			bottomSeparator.alpha = showsBottomSeparator ? 1 : 0
		}
	}
	
	var instructorName = "Instructor Name" {
		
		didSet {
			instructorNameLabel.text = instructorName.uppercased()
		}
		
	}
	
	var titleText = "Video Title" {
		
		didSet {
			titleLabel.text = titleText.uppercased()
		}
		
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		clipsToBounds = true
		
		setupThumbImageView()
		setupTitleView()
		setupTitleContent()
		setupBottomSeparator()
		setupBorders()
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupGradientShadow()
	}
	
	func setupGradientShadow() {
		
		guard gradientView == nil else { return }
		
		gradientView = UIView()
		gradientView.frame = contentView.bounds
		contentView.insertSubview(gradientView, aboveSubview: thumbImageView)
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = contentView.bounds
		gradientLayer.colors = [ UIColor(white: 0, alpha: 0.3).cgColor, UIColor(white: 0, alpha: 0.8).cgColor ]
		gradientView.layer.addSublayer(gradientLayer)
		
	}
	
	func setupBorders() {
		let topBorder = UIView()
		topBorder.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.6)
		topBorder.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(topBorder)
		
//		let bottomBorder = UIView()
//		bottomBorder.backgroundColor = .red
//		bottomBorder.translatesAutoresizingMaskIntoConstraints = false
//		contentView.addSubview(bottomBorder)
		
		NSLayoutConstraint.activate([
			
			topBorder.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			topBorder.heightAnchor.constraint(equalToConstant: 1),
			topBorder.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			topBorder.topAnchor.constraint(equalTo: contentView.topAnchor),
			
//			bottomBorder.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//			bottomBorder.heightAnchor.constraint(equalToConstant: 1),
//			bottomBorder.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//			bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
			
			])
		
	}
	
	func setupBottomSeparator() {
		
		bottomSeparator = UIView()
		bottomSeparator.backgroundColor = .black
		bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(bottomSeparator)
		
		NSLayoutConstraint.activate([
			
			bottomSeparator.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			bottomSeparator.heightAnchor.constraint(equalToConstant: 5),
			bottomSeparator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
			
			])
		
	}
	
	func setupThumbImageView() {
		
		thumbImageView.translatesAutoresizingMaskIntoConstraints = false
		thumbImageView.contentMode = .scaleAspectFill
		thumbImageView.clipsToBounds = true
		contentView.addSubview(thumbImageView)
		
		NSLayoutConstraint.activate([
			
			thumbImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			thumbImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
			thumbImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			thumbImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			
			])
		
	}
	
	func setupTitleView() {
		
		titleView.translatesAutoresizingMaskIntoConstraints = false
		titleView.clipsToBounds = true
		contentView.addSubview(titleView)
		
		NSLayoutConstraint.activate([
			
			
			titleView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			titleView.topAnchor.constraint(equalTo: contentView.centerYAnchor),
			titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
			titleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
			
			])
		
		
		// red left bar in title view
		leftBarView.translatesAutoresizingMaskIntoConstraints = false
		leftBarView.backgroundColor = .red
		titleView.addSubview(leftBarView)
		
		NSLayoutConstraint.activate([
			
			leftBarView.widthAnchor.constraint(equalToConstant: 5),
			leftBarView.heightAnchor.constraint(equalTo: titleView.heightAnchor),
			leftBarView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
			leftBarView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
			
			])
		
		
		playButtonView.translatesAutoresizingMaskIntoConstraints = false
		playButtonView.contentMode = .scaleAspectFit
		playButtonView.image = UIImage(named: "play")
		titleView.addSubview(playButtonView)
		
		NSLayoutConstraint.activate([
			
			playButtonView.widthAnchor.constraint(equalToConstant: 45),
			playButtonView.heightAnchor.constraint(equalToConstant: 45),
			playButtonView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			playButtonView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -padding)
			
			])
		
	}
	
	func setupTitleContent() {
		
		// setup the instructor name
		instructorNameLabel.translatesAutoresizingMaskIntoConstraints = false
		instructorNameLabel.textColor = .red
		instructorNameLabel.font = UIFont.systemFont(ofSize: 20)
		instructorNameLabel.text = instructorName.uppercased()
		instructorNameLabel.sizeToFit()
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.minimumScaleFactor = 0.5
		titleView.addSubview(instructorNameLabel)
		
		NSLayoutConstraint.activate([
			
			instructorNameLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
			instructorNameLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: padding),
			instructorNameLabel.trailingAnchor.constraint(equalTo: playButtonView.leadingAnchor, constant: -padding)
			
			])
		
		
		// setup the video title
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = .white
		titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
		titleLabel.text = titleText.uppercased()
		titleLabel.numberOfLines = 2
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.minimumScaleFactor = 0.5
		titleView.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			
			titleLabel.topAnchor.constraint(equalTo: instructorNameLabel.bottomAnchor, constant: 10),
			titleLabel.leadingAnchor.constraint(equalTo: instructorNameLabel.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: playButtonView.leadingAnchor, constant: -padding),
			titleView.bottomAnchor.constraint(equalTo: leftBarView.bottomAnchor)
			
			])
		
	}
	
}
