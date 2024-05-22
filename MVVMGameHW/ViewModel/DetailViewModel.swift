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
    var screenShots: ScreenShot? { get }
}

final class DetailViewModel{
    
    let service: GameServiceProtocol
    var gameDetail: GameDetail?
    var screenShot: ScreenShot?
    weak var delegate: DetailViewModelDelegate?
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
    
    /*fileprivate func fetchSingleGame(id: Int){
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
    
    fileprivate func fetchScreenShots(id: Int){
        service.fetchScreenShots(id: id) { [weak self] result in
            switch result{
            case .success(let screenShots):
                self?.screenShot = screenShots
               // self?.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }*/
    
    
    fileprivate func fetchSingleGame(id: Int, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        self.delegate?.showLoadingView()
        service.fetchSingleGame(id: id) { [weak self] result in
          /*  DispatchQueue.main.async {
                self?.delegate?.hideLodingView()
            }*/
            switch result {
            case .success(let detail):
                self?.gameDetail = detail
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    fileprivate func fetchScreenShots(id: Int, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        service.fetchScreenShots(id: id) { [weak self] result in
            switch result {
            case .success(let screenShots):
                self?.screenShot = screenShots
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
}

extension DetailViewModel: DetailViewModelProtocol{
    
   /* func load(id: Int?) {
        guard let id = id else{return}
        fetchSingleGame(id: id)
        fetchScreenShots(id: id)
    }*/
    
    func load(id: Int?) {
            guard let id = id else { return }
            
            let dispatchGroup = DispatchGroup()
            var fetchError: Error?
            
            dispatchGroup.enter()
            fetchSingleGame(id: id) { result in
                if case .failure(let error) = result {
                    fetchError = error
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
        
            fetchScreenShots(id: id) { result in
                if case .failure(let error) = result {
                    fetchError = error
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                if let error = fetchError {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.delegate?.hideLodingView()
                  }
                self.delegate?.reloadData()
            }
        }

    var gameDetails: GameDetail?{
        return gameDetail
    }
   
    var screenShots: ScreenShot? {
        return screenShot
    }
    
}
