//
//  RedditPost.swift
//  MVVMGameHW
//
//  Created by Erkan on 26.05.2024.
//

import Foundation

struct RedditResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [RedditPost]
}

struct RedditPost: Decodable {
    let id: Int?
    let name: String?
    let text: String?
    let image: String?
    let url: String?
    let username: String?
    let username_url: String?
    let created: String?
}

