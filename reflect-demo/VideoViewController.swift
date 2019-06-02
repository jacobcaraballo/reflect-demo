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
	
	var videos = [[Video]]()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor(white: 0, alpha: 1.0)
		
		// load videos
		loadVideos()
		
		
		// set the title to the filter title view
		navigationItem.titleView = getTitleView()
		
		
		// layout tableview and (hidden) category filter view
		setupTableView()
		setupCategoryFilterView()
	}
	
	func loadVideos() {
		
		let liveVideo = Video(title: "Total Body Workout", instructor: "Jama Oliver", thumbnail: "video1", command: "reflect - Jama 2")
		liveVideo.add(exercises: [
			
			Exercise(name: "Intro", lengthInSeconds: 25),
			Exercise(name: "Jumping Jacks", lengthInSeconds: 35),
			Exercise(name: "Forward Lunges", lengthInSeconds: 25),
			Exercise(name: "Walkout + Push Up", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Lateral Squat Walk", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Walkout + Tap", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Cooldown", lengthInSeconds: 45)
			
			])
		liveVideo.about = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
		
		let video1 = Video(title: "Strength Workout", instructor: "Jama Oliver", thumbnail: "video2", command: "Reflect- Jama-1mp4")
		video1.add(exercises: [
			
			Exercise(name: "Intro", lengthInSeconds: 25),
			Exercise(name: "Jumping Jacks", lengthInSeconds: 35),
			Exercise(name: "Forward Lunges", lengthInSeconds: 25),
			Exercise(name: "Walkout + Push Up", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Lateral Squat Walk", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Walkout + Tap", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Cooldown", lengthInSeconds: 45)
			
			])
		video1.about = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
		
		let video2 = Video(title: "Holy Hits", instructor: "Jamie Wilbanks", thumbnail: "video3", command: "reflect- Jamie")
		video2.add(exercises: [
			
			Exercise(name: "Intro", lengthInSeconds: 25),
			Exercise(name: "Jumping Jacks", lengthInSeconds: 35),
			Exercise(name: "Forward Lunges", lengthInSeconds: 25),
			Exercise(name: "Walkout + Push Up", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Lateral Squat Walk", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Walkout + Tap", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Cooldown", lengthInSeconds: 45)
			
			])
		video2.about = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
		
		let video3 = Video(title: "Body Weight Hit", instructor: "Marsha Goldberg", thumbnail: "video4", command: "reflect- Marsha-")
		video3.add(exercises: [
			
			Exercise(name: "Intro", lengthInSeconds: 25),
			Exercise(name: "Jumping Jacks", lengthInSeconds: 35),
			Exercise(name: "Forward Lunges", lengthInSeconds: 25),
			Exercise(name: "Walkout + Push Up", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Lateral Squat Walk", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Walkout + Tap", lengthInSeconds: 35),
			Exercise(name: "Rest", lengthInSeconds: 25),
			Exercise(name: "Cooldown", lengthInSeconds: 45)
			
			])
		video3.about = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
		
		videos.append([liveVideo])
		videos.append([video1, video2, video3])
		
	}
	
	func setupCategoryFilterView() {
		
		// init filter view with given category
		filterView = VideoCategoryFilterListView(height: 300, selected: category)
		filterView.translatesAutoresizingMaskIntoConstraints = false
		
		
		// setup filter delegates
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
		let imageSize: CGFloat = 15
		
		
		// title button for filter view
		let titleButton = UIButton()
		titleButton.setTitleColor(.white, for: .normal)
		titleButton.setTitleColor(UIColor(white: 0.7, alpha: 1), for: .highlighted)
		titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleButton.titleLabel!.font.pointSize)
		titleButton.setTitle(title, for: .normal)
		titleButton.sizeToFit()
		titleButton.addTarget(self, action: #selector(titleButtonPressed), for: .touchUpInside)
		
		
		// image view for rotating chevron
		titleChevronImageView = UIImageView(image: UIImage(named: "chevron"))
		titleChevronImageView.contentMode = .scaleAspectFill
		titleChevronImageView.frame = CGRect(x: titleButton.frame.size.width + padding, y: 0, width: imageSize, height: imageSize)
		titleChevronImageView.center.y = titleButton.center.y
		
		
		// get content dimensions
		let contentWidth = titleButton.frame.width + padding + imageSize
		let contentHeight = titleButton.frame.height
		
		
		// create container view
		let view = UIView(frame: CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight))
		view.addSubview(titleButton)
		view.addSubview(titleChevronImageView)
		
		
		// add a tap gesture to the view (for chevron)
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
		tableView.backgroundColor = nil
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
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return videos.count
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return videos[section].count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
		cell.selectionStyle = .none
		
		
		let video =  videos[indexPath.section][indexPath.row]
		cell.titleText = video.title
		cell.instructorName = video.instructor
		cell.thumbnail = video.thumbnail
		cell.showsBottomSeparator = indexPath.section != 0
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// show video description
		let video = videos[indexPath.section][indexPath.row]
		let videoDescriptionVC = VideoDescriptionViewController()
		videoDescriptionVC.video = video
		navigationController?.pushViewController(videoDescriptionVC, animated: true)
		
		
		// connect to mirror, if available
		guard let connectedService = CurrentlyConnectedService else { return }
		let videoCommand = video.command
		connectedService.write(string: videoCommand)
		
	}
	
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let text: NSMutableAttributedString
		let fontSize: CGFloat = 13
		let labelLeadingPadding: CGFloat = 15
		
		
		if section == 0 {
			let prestring = "REFLECT LIVE:"
			let string = "\(prestring) LIVE AND UPCOMING WORKOUTS"
			text = NSMutableAttributedString(string: string, attributes: [.foregroundColor: UIColor.white])
			text.addAttribute(.foregroundColor, value: UIColor.red, range: (string as NSString).range(of: prestring))
			text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(location: 0, length: string.count))
		} else {
			let prestring = "ON-DEMAND:"
			let string = "\(prestring) WORKOUT ON YOUR TIME"
			text = NSMutableAttributedString(string: string, attributes: [.foregroundColor: UIColor.white])
			text.addAttribute(.foregroundColor, value: UIColor.red, range: (string as NSString).range(of: prestring))
			text.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(location: 0, length: string.count))
		}
		
		
		let header = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.attributedText = text
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.5
		header.addSubview(label)
		
		
		NSLayoutConstraint.activate([
			
			label.widthAnchor.constraint(equalTo: header.widthAnchor, constant: -labelLeadingPadding),
			label.heightAnchor.constraint(equalTo: header.heightAnchor),
			label.centerYAnchor.constraint(equalTo: header.centerYAnchor),
			label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: labelLeadingPadding)
			
			])
		
		
		return header
		
	}
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 35
	}
	
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		guard section == 0 else { return UITableView.automaticDimension }
		return 0.00001
	}
	
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard section == 0 else { return nil }
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 0.00001))
		return view
	}
	
	
	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { return }
		cell.alpha = 0.6
	}
	
	
	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { return }
		cell.alpha = 1.0
	}
	
	
}
