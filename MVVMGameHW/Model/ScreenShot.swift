//
//  ScreenShot.swift
//  MVVMGameHW
//
//  Created by Erkan on 22.05.2024.
//

import Foundation

struct ScreenShot: Decodable {
    let count: Int?
    let results: [ScreenShotResult]?
}

struct ScreenShotResult: Decodable {
    let id: Int?
    let image: String?
    let width, height: Int?
    let isDeleted: Bool?

    enum CodingKeys: String, CodingKey {
        case id, image, width, height
        case isDeleted = "is_deleted"
    }
}
