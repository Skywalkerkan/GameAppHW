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
    func load(nextPage: String?)
    func game(indexPath: IndexPath) -> Result?
    var nextPage: String? { get set}
}

final class HomeViewModel{
    
    let service: GameServiceProtocol
    var games = [Result]()
    var nextPage: String?
    weak var delegate: HomeViewModelDelegate?
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchGames(nextPage: String?){

        service.fetchListOfGames(nextPage: nextPage ?? nil) { [weak self] result in
            print("ok")
            switch result{
            case .success(let gameResult):
                DispatchQueue.main.async {
                    print("Yükleniyor")
                    self?.games += gameResult.results ?? []
                    self?.nextPage = gameResult.next
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol{
     
    func load(nextPage: String?) {
        fetchGames(nextPage: nextPage)
    }
    
    func game(indexPath: IndexPath) -> Result? {
        games[indexPath.row]
    }
    
    var nextPageUrlString: String?{
        return nextPage
    }
        
    var numberOfItems: Int {
        print("oyun sayısı \(games.count)")
       return games.count
    }
    
}
