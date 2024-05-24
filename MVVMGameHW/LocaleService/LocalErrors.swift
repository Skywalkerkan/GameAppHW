//
//  LocalErrors.swift
//  MVVMGameHW
//
//  Created by Erkan on 24.05.2024.
//

import Foundation


enum LocalError: Error{
    
    case fetchingError
    case deleteError(_ Error: Error)
    case saveError(_ Error: Error)
    case notFoundError

    
}
