//
//  FavoriteViewModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 24.05.2024.
//

import Foundation

protocol FavoriteViewModelDelegate: AnyObject{
    func reloadData()
    func showError(_ error: String)
}

protocol FavoriteViewModelProtocol{
    var delegate: FavoriteViewModelDelegate? { get set }
    func load()
    var numberOfItems: Int { get }
    func game(indexPath: IndexPath) -> Game?
}


final class FavoriteViewModel{
    
    let service: LocalServiceProtocol
    var savedGames: [Game] = []

    weak var delegate: FavoriteViewModelDelegate?
    init(service: LocalServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchSavedGames(){
        service.fetchGames { result in
            switch result{
            case .success(let games):
                self.savedGames = games
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
}


extension FavoriteViewModel: FavoriteViewModelProtocol{
    var numberOfItems: Int {
        savedGames.count
    }
    
    func game(indexPath: IndexPath) -> Game? {
        savedGames[indexPath.row]
    }
    
    func load() {
        print("Girdi")
        fetchSavedGames()
    }

}
