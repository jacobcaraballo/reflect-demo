//
//  VideoCategoryFilterListView.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/2/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class VideoCategoryFilterListView: UIView {
	
	let tableView = UITableView()
	let listHeight: CGFloat
	let rowHeight: CGFloat
	let categories = [
		"Favorites",
		"Cardio",
		"Yoga",
		"Strength",
		"Pilates",
		"Boxing"
	]
	var selectedIndexPath: IndexPath!
	var selectedCategory: String
	
	var revealingConstraint: NSLayoutConstraint!
	var isShowing: Bool {
		return revealingConstraint.constant == 0
	}
	let shadow = UIView()
	var willShow: (() -> ())?
	var didShow: (() -> ())?
	var willHide: (() -> ())?
	var didHide: (() -> ())?
	var didSelect: ((String) -> ())?
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(height: CGFloat, selected: String) {
		selectedCategory = selected.uppercased()
		listHeight = height
		rowHeight = height / CGFloat(categories.count)
		super.init(frame: .zero)
		
		setupBackgroundShadow()
		setupTableView()
		isHidden = true
		clipsToBounds = true
	}
	
	func setupTableView() {
		
		tableView.backgroundColor = UIColor(white: 0.1, alpha: 1)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = rowHeight
		tableView.delegate = self
		tableView.dataSource = self
		tableView.isScrollEnabled = false
		tableView.separatorColor = .black
		addSubview(tableView)
		
		
		revealingConstraint = tableView.topAnchor.constraint(equalTo: topAnchor, constant: -listHeight)
		NSLayoutConstraint.activate([
			
			tableView.widthAnchor.constraint(equalTo: widthAnchor),
			tableView.heightAnchor.constraint(equalToConstant: listHeight),
			tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
			revealingConstraint
			
			])
		
	}
	
	func setupBackgroundShadow() {
		
		shadow.translatesAutoresizingMaskIntoConstraints = false
		shadow.backgroundColor = UIColor(white: 0, alpha: 0.6)
		shadow.alpha = 0
		addSubview(shadow)
		
		NSLayoutConstraint.activate([
			
			shadow.widthAnchor.constraint(equalTo: widthAnchor),
			shadow.heightAnchor.constraint(equalTo: heightAnchor),
			shadow.centerXAnchor.constraint(equalTo: centerXAnchor),
			shadow.centerYAnchor.constraint(equalTo: centerYAnchor)
			
			])
		
		
		// tap gesture for shadow
		let tap = UITapGestureRecognizer(target: self, action: #selector(shadowWasTapped))
		shadow.addGestureRecognizer(tap)
		
	}
	
	@objc func shadowWasTapped() {
		hide()
	}
	
	func toggle() {
		
		if isShowing {
			hide()
		} else {
			reveal()
		}
		
	}
	
	func reveal() {
		
		willShow?()
		isHidden = false
		revealingConstraint.constant = 0
		
		let anim = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
			self.layoutIfNeeded()
			self.shadow.alpha = 1
		}
		anim.addCompletion { _ in
			self.didShow?()
		}
		anim.startAnimation()
		
	}
	
	func hide() {
		
		willHide?()
		revealingConstraint.constant = -listHeight
		
		let anim = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
			self.layoutIfNeeded()
			self.shadow.alpha = 0
		}
		anim.addCompletion { _ in
			self.isHidden = true
			self.didHide?()
		}
		anim.startAnimation()
		
	}
	
}

extension VideoCategoryFilterListView: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "ListCell")
		
		if cell == nil {
			
			cell = UITableViewCell(style: .default, reuseIdentifier: "ListCell")
			cell.backgroundColor = nil
			cell.textLabel?.textAlignment = .center
			cell.selectionStyle = .none
			
		}
		
		let category = categories[indexPath.row].uppercased()
		cell.textLabel?.text = category
		cell.textLabel?.textColor = category == selectedCategory ? .red : .white
		
		if category == selectedCategory {
			selectedIndexPath = indexPath
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let category = categories[indexPath.row].uppercased()
		guard category != selectedCategory else { return }
		
		// reset currently selected cell color
		tableView.cellForRow(at: selectedIndexPath)?.textLabel?.textColor = .white
		
		
		// set the selected category
		selectedIndexPath = indexPath
		selectedCategory = category
		
		
		// set selected cell color to red
		tableView.cellForRow(at: selectedIndexPath)?.textLabel?.textColor = .red
		
		
		// select the new category
		didSelect?(category)
		hide()
		
	}
	
	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { return }
		cell.contentView.alpha = 0.5
	}
	
	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { return }
		cell.contentView.alpha = 1.0
	}
	
}
