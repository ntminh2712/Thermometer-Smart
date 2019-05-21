//
//  Response.swift
//  Library
//
//  Created by Cosmin Stirbu on 2/23/17.
//  MIT License
//
//  Copyright (c) 2017 Fortech
//


import Foundation

struct CoreError: Error {
	var localizedDescription: String {
		return message
	}
	
	var message = ""
}

// See https://github.com/antitypical/Result
enum Result<T> {
	case success(T)
	case failure(Error)
	
	public func dematerialize() throws -> T {
		switch self {
		case let .success(value):
			return value
		case let .failure(error):
			throw error
		}
	}
}
