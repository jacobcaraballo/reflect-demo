//
//  ViewController.swift
//  mirror-workout-demo
//
//  Created by Jacob Caraballo on 12/31/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	let tableView = UITableView()
	let rowHeightCollapsed: CGFloat = 150
	let rowHeightExpanded: CGFloat = 350
	let categories = [
		"Cardio",
		"Yoga",
		"Strength",
		"Pilates",
		"Boxing"
	]
	var selectedIndexPath: IndexPath?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set the navigation bar title
		title = "WORKOUTS"
		view.backgroundColor = .black
		
		setupLoginView()
		setupTableView()
	}
	
	private func setupLoginView() {
		
		let loginView = LoginView()
		loginView.didAuthenticate = {
			MDNSReflectBrowser.start()
		}
		navigationController?.present(loginView, animated: false, completion: nil)
		
	}
	
	
	func setupTableView() {
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = rowHeightCollapsed
		tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
		
		
		// get category
		let category = categories[indexPath.row]
		cell.imageName = category.lowercased()
		cell.title = category.uppercased()
		cell.selectionStyle = .none
		
		
		
		// expand cell if selected, else reset expansion
		if indexPath == selectedIndexPath {
			cell.toggle(expanded: true, animated: false)
		} else {
			cell.toggle(expanded: false, animated: false)
		}
		
		
		
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		guard indexPath != selectedIndexPath else { return rowHeightExpanded }
		return rowHeightCollapsed
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		guard indexPath != selectedIndexPath else { return rowHeightExpanded }
		return rowHeightCollapsed
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
		// get cell for this index
		let cell = tableView.cellForRow(at: indexPath) as! CategoryCell
		
		
		// deselect this row
		tableView.deselectRow(at: indexPath, animated: false)
		
		
		// reset the expanded row
		let resetIndexPath = resetCurrentlyExpandedRow()
		
		
		// if the row is expanded, then we move to the page
		// otherwise, expand the cell
		if indexPath == resetIndexPath {
			
			let videoVC = VideoViewController()
			videoVC.category = categories[indexPath.row]
			navigationController?.pushViewController(videoVC, animated: true)
			
		} else {
			selectedIndexPath = indexPath
			cell.toggle(expanded: true, animated: true)
		}
		
		
		// update the tableView according to the selection
		tableView.beginUpdates()
		tableView.endUpdates()
		
		
		// scroll to cell
		tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
		
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		// use an empty view to hide trailing unused cells
		let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
		return emptyView
	}
	
	
	// returns the indexpath that was reset
	@discardableResult
	func resetCurrentlyExpandedRow() -> IndexPath? {
		
		guard let indexPath = selectedIndexPath, let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else { return nil }
		cell.toggle(expanded: false, animated: true)
		let resetIndexPath = selectedIndexPath
		selectedIndexPath = nil
		return resetIndexPath
		
	}
	
}
