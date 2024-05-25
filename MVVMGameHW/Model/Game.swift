//
//  Game.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import Foundation

import Foundation

// MARK: - GameResult
struct GameResult: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let description: String?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description
        case nofollowCollections = "nofollow_collections"
    }
}



// MARK: - YearYear
struct YearYear: Decodable {
    let year, count: Int?
    let nofollow: Bool?
}

// MARK: - Result
struct Result: Decodable {
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount: Int?
    let metacritic, playtime, suggestionsCount: Int?
    let reviewsCount: Int?
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let tags: [Genre]?
    let esrbRating: EsrbRating?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case reviewsCount = "reviews_count"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, tags
        case esrbRating = "esrb_rating"
    }
}
 
// MARK: - EsrbRating
struct EsrbRating: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name, slug: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}

enum Domain: String, Decodable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}

enum Language: String, Decodable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Decodable {
    let platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement: Decodable {
    let platform: PlatformPlatform?
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Decodable {
    let id: Int?
    let name, slug: String?
    let image, yearEnd: String?
    let yearStart: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Decodable {
    let minimum, recommended: String?
}

// MARK: - Rating
struct Rating: Decodable {
    let id: Int?
    let title: Title?
    let count: Int?
    let percent: Double?
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}
