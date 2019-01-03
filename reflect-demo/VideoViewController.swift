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
	var category: String?
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
		
		view.backgroundColor = .black		
		setupTableView()
	}
	
	func setupTableView() {
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 250
		tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
		tableView.backgroundColor = nil
//		tableView.separatorColor = .black
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
