//
//  VideoViewController.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 12/31/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class VideoViewController: UIViewController {
	
	let tableView = UITableView(frame: .zero, style: .grouped)
	var titleChevronImageView: UIImageView!
	var category: String!
	var filterView: VideoCategoryFilterListView!
	let videos = [
		
		"20 Min Ultimate Cardio Kick Boxing",
		"Cardio Abs",
		"Speed Workout",
		"20 Min Ultimate Cardio Kick Boxing",
		"Cardio Abs"
		
	]
	let thumbnails = [
		
		"video1",
		"video2",
		"video3",
		"video1",
		"video2"
		
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .done, target: self, action: #selector(menuButtonPressed))
		navigationItem.titleView = getTitleView()
		view.backgroundColor = .black
		setupTableView()
		setupCategoryFilterView()
	}
	
	func setupCategoryFilterView() {
		
		filterView = VideoCategoryFilterListView(height: 300, selected: category)
		filterView.willShow = {
			self.navigationItem.titleView?.isUserInteractionEnabled = false
			self.rotateChevronForOpen()
		}
		filterView.willHide = {
			self.navigationItem.titleView?.isUserInteractionEnabled = false
			self.rotateChevronForClose()
		}
		filterView.didShow = {
			self.navigationItem.titleView?.isUserInteractionEnabled = true
		}
		filterView.didHide = {
			self.navigationItem.titleView?.isUserInteractionEnabled = true
		}
		filterView.didSelect = { category in
			self.category = category
			self.navigationItem.titleView = self.getTitleView()
		}
		filterView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(filterView)
		
		NSLayoutConstraint.activate([
			
			filterView.widthAnchor.constraint(equalTo: view.widthAnchor),
			filterView.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height),
			filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			filterView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
			
			])
		
	}
	
	func getTitleView() -> UIView? {
		
		guard let title = category?.uppercased() else { return nil }
		
		let padding: CGFloat = 5
		
		let titleButton = UIButton()
		titleButton.setTitleColor(.white, for: .normal)
		titleButton.setTitleColor(UIColor(white: 0.7, alpha: 1), for: .highlighted)
		titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleButton.titleLabel!.font.pointSize)
		titleButton.setTitle(title, for: .normal)
		titleButton.sizeToFit()
		titleButton.addTarget(self, action: #selector(titleButtonPressed), for: .touchUpInside)
		
		let imageSize: CGFloat = 15
		titleChevronImageView = UIImageView(image: UIImage(named: "chevron"))
		titleChevronImageView.contentMode = .scaleAspectFill
		titleChevronImageView.frame = CGRect(x: titleButton.frame.size.width + padding, y: 0, width: imageSize, height: imageSize)
		titleChevronImageView.center.y = titleButton.center.y
		
		let contentWidth = titleButton.frame.width + padding + imageSize
		let contentHeight = titleButton.frame.height
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight))
		view.addSubview(titleButton)
		view.addSubview(titleChevronImageView)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(titleButtonPressed))
		view.addGestureRecognizer(tap)
		
		return view
		
	}
	
	@objc func titleButtonPressed() {
		filterView.toggle()
	}
	
	func rotateChevronForClose() {
		let anim = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
			self.titleChevronImageView.setRotation(angle: 0)
		}
		anim.startAnimation()
	}
	
	func rotateChevronForOpen() {
		let anim = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
			self.titleChevronImageView.setRotation(angle: 0.999 * CGFloat.pi)
		}
		anim.startAnimation()
	}
	
	@objc func menuButtonPressed() {
		navigationController?.popToRootViewController(animated: true)
	}
	
	func setupTableView() {
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 250
		tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
		tableView.backgroundColor = .black
		tableView.separatorStyle = .none
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			
			tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
			tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
			tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			
			])
		
	}
	
}


extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return videos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
		cell.selectionStyle = .none
		cell.instructorName = "Instructor Name"
		cell.titleText = videos[indexPath.row]
		cell.thumbnail = thumbnails[indexPath.row]
		return cell
	}
	
}
