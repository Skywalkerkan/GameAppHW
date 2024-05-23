//
//  ScreenShot.swift
//  MVVMGameHW
//
//  Created by Erkan on 22.05.2024.
//

import Foundation

struct ScreenShot: Decodable {
    let results: [ScreenShotResult]?
}

struct ScreenShotResult: Decodable {
    let id: Int?
    let image: String?


    enum CodingKeys: String, CodingKey {
        case id, image
    }
}
