//
//  DetailViewModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLodingView()
    func reloadData()
}

protocol DetailViewModelProtocol{
    var delegate: DetailViewModelDelegate? { get set }
    func load(id: Int?)
    var gameDetails: GameDetail? { get }
}

final class DetailViewModel{
    
    let service: GameServiceProtocol
    var gameDetail: GameDetail?
    weak var delegate: DetailViewModelDelegate?
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchSingleGame(id: Int){
        self.delegate?.showLoadingView()
        service.fetchSingleGame(id: id) { [weak self] result in
            switch result{
            case .success(let detail):
                DispatchQueue.main.async{
                    self?.delegate?.hideLodingView()
                }
                self?.gameDetail = detail
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DetailViewModel: DetailViewModelProtocol{
    
    func load(id: Int?) {
        guard let id = id else{return}
        fetchSingleGame(id: id)
    }

    var gameDetails: GameDetail?{
        return gameDetail
    }
     
}
