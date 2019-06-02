//
//  VideoDescriptionHeaderView.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/22/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class VideoDescriptionHeaderView: UIView {
	
	let padding = UIEdgeInsets(horizontal: 20, vertical: 10)
	
	let video: Video
	let imageView = UIImageView()
	var expectedHeight: CGFloat = 0
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(video: Video) {
		self.video = video
		super.init(frame: .zero)
		
		setupImageView()
		setupAboutView()
	}
	
	func setupImageView() {
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		addSubview(imageView)
		
		NSLayoutConstraint.activate([
			
			imageView.widthAnchor.constraint(equalTo: widthAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 300),
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.topAnchor.constraint(equalTo: topAnchor)
			
			])
		
		expectedHeight += 300
		
	}
	
	func setupAboutView() {
		
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "ABOUT THIS WORKOUT"
		title.textColor = .white
		title.font = UIFont.boldSystemFont(ofSize: 15)
		title.sizeToFit()
		addSubview(title)
		
		let sep = UIView()
		sep.backgroundColor = UIColor(white: 1, alpha: 0.5)
		sep.translatesAutoresizingMaskIntoConstraints = false
		addSubview(sep)
		
		let about = UILabel()
		about.translatesAutoresizingMaskIntoConstraints = false
		about.text = video.about
		about.textColor = .white
		about.font = UIFont.systemFont(ofSize: 13)
		about.numberOfLines = 4
		about.sizeToFit()
		about.frame.size.width = UIScreen.main.bounds.width - (2 * padding.horizontal)
		addSubview(about)
		
		
		NSLayoutConstraint.activate([
			
			title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.horizontal),
			title.topAnchor.constraint(equalTo: imageView.bottomAnchor),
			
			sep.widthAnchor.constraint(equalTo: widthAnchor),
			sep.heightAnchor.constraint(equalToConstant: 1),
			sep.centerXAnchor.constraint(equalTo: centerXAnchor),
			sep.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding.vertical),
			
			about.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.horizontal),
			about.topAnchor.constraint(equalTo: sep.bottomAnchor, constant: padding.vertical),
			about.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.horizontal)
			
			])
		
		
		expectedHeight += title.frame.height + padding.vertical + 1 + padding.vertical + about.frame.height + 40
		
		
	}
	
}
