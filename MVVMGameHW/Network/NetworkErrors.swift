//
//  NetworkErrors.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(_ url: String)
    case networkError(_ error: Error)
    case invalidData
    case decodeError
}
