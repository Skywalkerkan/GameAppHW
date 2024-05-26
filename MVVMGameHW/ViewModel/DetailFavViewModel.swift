//
//  DetailFavViewModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 24.05.2024.
//

import Foundation

protocol DetailFavViewModelDelegate: AnyObject{
    func isSaved()
    func isStarredFunc()
    func showDetailFavError(error: Error)
}

protocol DetailFavViewModelProtocol{
    var delegate: DetailFavViewModelDelegate? { get set }
    func saveItem(gameModel: GameLocalModel)
    func deleteItem(id: Int)
    func isFavorited(id: Int)
    var isStarred: Bool {get}
}

final class DetailFavViewModel{
    
    let service: LocalServiceProtocol
    var isFavorited: Bool = false
    weak var delegate: DetailFavViewModelDelegate?
    
    init(service: LocalServiceProtocol) {
        self.service = service
    }
    
    fileprivate func saveGame(gameModel: GameLocalModel){
        service.saveGame(gameModel: gameModel) { result in
            switch result{
            case .success(_):
                self.isFavorited = true
                self.delegate?.isSaved()
            case .failure(let error):
                self.delegate?.showDetailFavError(error: error)
            }
        }
    }
    
    fileprivate func deleteGame(id: Int){
        service.deleteGame(id: id) { result in
            switch result{
            case .success():
                self.isFavorited = false
                self.delegate?.isSaved()
            case .failure(let error):
                self.delegate?.showDetailFavError(error: error)
            }
        }
    }
    
    fileprivate func isStarred(id: Int){
        service.isFavorited(id: id) { result in
            if result{
                self.isFavorited = true
            }else{
                self.isFavorited = false
            }
            self.delegate?.isStarredFunc()
        }
    }
}


extension DetailFavViewModel: DetailFavViewModelProtocol{
   
    func saveItem(gameModel: GameLocalModel) {
        saveGame(gameModel: gameModel)
    }
    
    func deleteItem(id: Int) {
        deleteGame(id: id)
    }
    
    func isFavorited(id: Int) {
        isStarred(id: id)
    }
    
    var isStarred: Bool{
        isFavorited
    }
    
}
