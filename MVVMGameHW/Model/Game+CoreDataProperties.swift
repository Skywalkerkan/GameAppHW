//
//  Game+CoreDataProperties.swift
//  MVVMGameHW
//
//  Created by Erkan on 24.05.2024.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var genres: String?
    @NSManaged public var platforms: String?

}

extension Game : Identifiable {

}
