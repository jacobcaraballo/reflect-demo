//
//  VideoDescriptionView.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/22/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit


class VideoDescriptionViewController: UIViewController {
	
	var video: Video!
	let tableView = UITableView(frame: .zero, style: .grouped)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .black
		title = video.title.uppercased()
		
		layoutTableView()
	}
	
	func layoutTableView() {
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.showsVerticalScrollIndicator = false
		tableView.backgroundColor = .clear
		tableView.tintColor = .white
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 65
		view.addSubview(tableView)
		
		
		let header = VideoDescriptionHeaderView(video: video)
		header.frame.size.height = header.expectedHeight
		header.frame.size.width = 1
		header.imageView.image = UIImage(named: video.thumbnail)
		tableView.tableHeaderView = header
		
		
		NSLayoutConstraint.activate([
			
			tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
			tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
			tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			
			])
		
		
	}
	
}

extension VideoDescriptionViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return video.numberOfExercises
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell")
		
		if cell == nil {
			cell = UITableViewCell(style: .value1, reuseIdentifier: "ExerciseCell")
			cell.accessoryType = .none
			cell.backgroundColor = .clear
			cell.selectionStyle = .none
		}
		
		let exercise = video.get(exerciseAtIndex: indexPath.row)
		cell.textLabel?.text = exercise.name.uppercased()
		cell.textLabel?.textColor = .white
		cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
		cell.detailTextLabel?.text = "00:\(exercise.lengthInSeconds)"
		cell.detailTextLabel?.textColor = .white
		cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "\(video.numberOfExercises) Exercises"
	}
	
}
