//
//  CoreDataService.swift
//  MVVMGameHW
//
//  Created by Erkan on 24.05.2024.
//

import Foundation
import CoreData
import UIKit


protocol LocalServiceProtocol {
    func saveGame(gameModel: GameLocalModel, completion: @escaping (Swift.Result<Game, LocalError>) -> Void)
    func fetchGames(completion: @escaping (Swift.Result<[Game], LocalError>) -> Void)
    func deleteGame(id: Int, completion: @escaping (Swift.Result<Void, LocalError>) -> Void)
    func isFavorited(id: Int, completion: @escaping (Bool) -> Void)
}

// MARK: - LocalService
class LocalService: LocalServiceProtocol{
    
    private let persistentContainer: NSPersistentContainer
     
     init(container: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer) {
         self.persistentContainer = container
     }
    
    func saveGame(gameModel: GameLocalModel, completion: @escaping (Swift.Result<Game, LocalError>) -> Void) {
        let context = persistentContainer.viewContext
        let game = Game(context: context)
        game.id = Int32(gameModel.gameId)
        game.name = gameModel.name
        game.genres = gameModel.genres
        game.image = gameModel.imageData
        game.platforms = gameModel.platforms
        
        do {
            try context.save()
            completion(.success(game))
        } catch {
            completion(.failure(.saveError(error)))
        }
    }
    
    func fetchGames(completion: @escaping (Swift.Result<[Game], LocalError>) -> Void){
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        
        do {
            let games = try context.fetch(fetchRequest)
            completion(.success(games))
        } catch{
            completion(.failure(.fetchingError))
        }
    }
    
    func deleteGame(id: Int, completion: @escaping (Swift.Result<Void, LocalError>) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            let games = try context.fetch(fetchRequest)
            if let game = games.first{
                context.delete(game)
                try context.save()
                completion(.success(()))
            }else{
                completion(.failure(.notFoundError))
            }
        } catch{
            completion(.failure(.deleteError(error)))
        }
    }
    
    func isFavorited(id: Int, completion: @escaping (Bool) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let games = try context.fetch(fetchRequest)
            if games.first != nil {
                completion(true)
            } else {
                completion(false)
            }
        } catch {
            completion(false)
        }
    }
}

