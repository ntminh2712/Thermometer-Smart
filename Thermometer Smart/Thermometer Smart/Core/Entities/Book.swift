//
//  Book.swift
//  Library
//
//  Created by Cosmin Stirbu on 2/23/17.
//  MIT License
//
//  Copyright (c) 2017 Fortech
//

import Foundation

struct Book {
	var id: String
	var isbn: String
	var title: String
	var author: String
	var releaseDate: Date?
	var pages: Int
	
	var durationToReadInHours: Double {
		
		return Double(pages) / 30.0
	}
}

extension Book: Equatable { }

func == (lhs: Book, rhs: Book) -> Bool {
	return lhs.id == rhs.id
}
