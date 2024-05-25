//
//  SearchModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 25.05.2024.
//



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let search = try? JSONDecoder().decode(Search.self, from: jsonData)

import Foundation

// MARK: - Search
struct Search: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - Result
struct SearchResult: Decodable {
    let slug, name: String?
    let playtime: Int?
    let platforms: [Platform]?
    let stores: [Store]?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, metacritic, reviewsTextCount, added: Int?
    let addedByStatus: AddedByStatus?
    let suggestionsCount: Int?
    let updated: String?
    let id: Int?
    let score: String?
    let tags: [Tag]?
    let esrbRating: EsrbRating?
    let reviewsCount, communityRating: Int?
    let saturatedColor, dominantColor: Color?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case slug, name, playtime, platforms, stores, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic
        case addedByStatus = "added_by_status"
        case suggestionsCount = "suggestions_count"
        case updated, id, score, tags
        case esrbRating = "esrb_rating"
        case reviewsCount = "reviews_count"
        case communityRating = "community_rating"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case genres
    }
}

// MARK: - Platform
struct Platform: Decodable {
    let platform: Genre?
}


// MARK: - AddedByStatus
struct AddedByStatus: Decodable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}

enum Color: String, Decodable {
    case the0F0F0F = "0f0f0f"
}


// MARK: - Tag
struct Tag: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
