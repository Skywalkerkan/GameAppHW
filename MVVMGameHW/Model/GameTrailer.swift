//
//  GameTrailer.swift
//  MVVMGameHW
//
//  Created by Erkan on 23.05.2024.
//

import Foundation


struct Trailer: Codable {
    let results: [TrailerResult]?
}

struct TrailerResult: Codable {
    let name: String?
    let preview: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let the480, max: String?

    enum CodingKeys: String, CodingKey {
        case the480 = "480"
        case max
    }
}
