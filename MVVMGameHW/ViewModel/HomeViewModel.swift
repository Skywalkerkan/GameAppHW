//
//  HomeViewModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

protocol HomeViewModelProtocol{
    var delegate: HomeViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load(nextPage: String?)
    func search(searchText: String?)
    func game(indexPath: IndexPath) -> Result?
    var allSearchGames: [Result]? { get}
    var allGames: [Result]? {get}
    var nextPage: String? { get set}
}

final class HomeViewModel{
    
    let service: GameServiceProtocol
    var games = [Result]()
    var searchGames = [Result]()
    var nextPage: String?
    weak var delegate: HomeViewModelDelegate?
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchGames(nextPage: String?){
        self.delegate?.showLoadingView()
        service.fetchListOfGames(nextPage: nextPage ?? nil) { [weak self] result in
            switch result{
            case .success(let gameResult):
                DispatchQueue.main.async {
                    self?.delegate?.hideLoadingView()
                    self?.games += gameResult.results ?? []
                    self?.nextPage = gameResult.next
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func fetchSearchGames(searchText: String?){
        self.delegate?.showLoadingView()
        service.fetchSearchGames(searchString: searchText ?? " ") {  [weak self] result in
            switch result{
            case .success(let gameResult):
                DispatchQueue.main.async{
                    self?.delegate?.hideLoadingView()
                    self?.searchGames = gameResult.results ?? []
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol{
   
    var allGames: [Result]? {
        games
    }
    
    var allSearchGames: [Result]? {
        searchGames
    }
    
     
    func load(nextPage: String?) {
        fetchGames(nextPage: nextPage)
    }
    
    func search(searchText: String?){
        fetchSearchGames(searchText: searchText)
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
