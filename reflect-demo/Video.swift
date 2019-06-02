//
//  Video.swift
//  reflect-demo
//
//  Created by Jacob Caraballo on 1/4/19.
//  Copyright © 2019 Jacob Caraballo. All rights reserved.
//

import Foundation

enum VideoCategory {
	case cardio, yoga, strength, pilates, boxing
}

class Exercise {
	var name: String
	var lengthInSeconds: Int
	
	init(name: String, lengthInSeconds: Int) {
		self.name = name
		self.lengthInSeconds = lengthInSeconds
	}
}

class Video {
	
	var title: String
	var instructor: String
	var thumbnail: String
	var command: String
	
	var about = ""
	var level: Int = 0
	var lengthInMinutes: Int = 0
	var date: Date = Date()
	private var categories = [VideoCategory]()
	private var exercises = [Exercise]()
	var numberOfExercises: Int {
		return exercises.count
	}
	
	init(title: String, instructor: String, thumbnail: String, command: String) {
		self.title = title
		self.instructor = instructor
		self.thumbnail = thumbnail
		self.command = command
	}
	
	func add(category: VideoCategory) {
		categories.append(category)
	}
	
	func add(exercises: [Exercise]) {
		self.exercises.append(contentsOf: exercises)
	}
	
	func get(exerciseAtIndex index: Int) -> Exercise {
		return exercises[index]
	}
	
}
