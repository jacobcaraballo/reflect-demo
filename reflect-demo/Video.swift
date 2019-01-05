//
//  Video.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/4/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation

class Video {
	
	var title: String
	var instructor: String
	var thumbnail: String
	var command: String
	
	init(title: String, instructor: String, thumbnail: String, command: String) {
		self.title = title
		self.instructor = instructor
		self.thumbnail = thumbnail
		self.command = command
	}
	
}
