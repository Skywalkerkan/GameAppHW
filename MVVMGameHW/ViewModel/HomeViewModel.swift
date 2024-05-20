//
//  HomeViewModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
   // func showLoadingView()
   // func hideLodingView()
    func reloadData()
}

protocol HomeViewModelProtocol{
    var delegate: HomeViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load()
    func game(indexPath: IndexPath) -> Result?
}

final class HomeViewModel{
    
    let service: GameServiceProtocol
    var games = [Result]()
    weak var delegate: HomeViewModelDelegate?
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchGames(){
        service.fetchListOfGames { [weak self] result in
            print("ok")
            switch result{
            case .success(let gameResult):
                DispatchQueue.main.async {
                    self?.games = gameResult.results ?? []
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol{
 
    
    func load() {
        fetchGames()
    }
    
    func game(indexPath: IndexPath) -> Result? {
        games[indexPath.row]
    }
    var numberOfItems: Int {
        print("oyun sayısı \(games.count)")
       return games.count
    }
    
}
