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
    func showError(_ error: String)
}

protocol DetailViewModelProtocol{
    var delegate: DetailViewModelDelegate? { get set }
    func load(id: Int?)
    var gameDetails: GameDetail? { get }
    var screenShots: ScreenShot? { get }
    var trailers: Trailer? { get }
    var mediaItems: [MediaItem]? { get }
    var redditPosts: [RedditPost]? { get }
}

enum MediaItem {
    case screenshot(ScreenShotResult)
    case trailer(TrailerResult)
}

final class DetailViewModel{
    
    let service: GameServiceProtocol
    var gameDetail: GameDetail?
    var screenShot: ScreenShot?
    var mediaItem: [MediaItem]?
    var trailer: Trailer?
    var comments: RedditResponse?
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
    
    fileprivate func fetchTrailers(id: Int, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        service.fetchTrailers(id: id) { [weak self] result in
            switch result {
            case .success(let trailers):
                self?.trailer = trailers
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    fileprivate func fetchRedditComments(id: Int, completion: @escaping (Swift.Result<Void, Error>) -> Void){
        service.fetchRedditComment(id: id) { [weak self] result in
            switch result{
            case .success(let redditResponse):
                self?.comments = redditResponse
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
        
        //SİNGLE
        dispatchGroup.enter()
        fetchSingleGame(id: id) { result in
            if case .failure(let error) = result {
                fetchError = error
            }
            dispatchGroup.leave()
        }
        //ScreenShots
        dispatchGroup.enter()
        fetchScreenShots(id: id) { result in
            if case .failure(let error) = result {
                fetchError = error
            }
            dispatchGroup.leave()
        }
        
        //Trailers
        dispatchGroup.enter()
        fetchTrailers(id: id) { result in
            if case .failure(let error) = result {
                fetchError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchRedditComments(id: id) { result in
            if case .failure(let error) = result {
                fetchError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = fetchError {
                print("Error: \(error.localizedDescription)")
                self.delegate?.showError(error.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                self.delegate?.hideLodingView()
            }
            self.delegate?.reloadData()
        }
    }
    
    
    var redditPosts: [RedditPost]? {
        return comments?.results
    }
    
    var gameDetails: GameDetail?{
        return gameDetail
    }
   
    var screenShots: ScreenShot? {
        return screenShot
    }
    
    var trailers: Trailer? {
        return trailer
    }
    
    var mediaItems: [MediaItem]? {
        var items: [MediaItem] = []
        
        if let trailers = trailer?.results {
            items += trailers.map { MediaItem.trailer($0) }
        }
        
        if let screenShots = screenShot?.results {
            items += screenShots.map { MediaItem.screenshot($0) }
        }
        
        return items
    }
    
}
