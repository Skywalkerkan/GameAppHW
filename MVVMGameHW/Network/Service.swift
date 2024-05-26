//
//  Service.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import Foundation

protocol GameServiceProtocol {
    func fetchListOfGames(nextPage: String?, completion: @escaping (Swift.Result<GameResult, NetworkError>) -> Void)
    func fetchSingleGame(id: Int, completion: @escaping (Swift.Result<GameDetail, NetworkError>) -> Void)
    func fetchScreenShots(id: Int, completion: @escaping (Swift.Result<ScreenShot, NetworkError>) -> Void)
    func fetchTrailers(id: Int, completion: @escaping (Swift.Result<Trailer, NetworkError>) -> Void)
    func fetchSearchGames(searchString: String, completion: @escaping (Swift.Result<Search, NetworkError>) -> Void)
    func fetchRedditComment(id: Int, completion: @escaping (Swift.Result<RedditResponse, NetworkError>) -> Void)

}

class GameService: GameServiceProtocol {
    
    private func performRequest<T: Decodable>(url: URL, completion: @escaping (Swift.Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.statusError))
                return
            }
        
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    func fetchListOfGames(nextPage: String?, completion: @escaping (Swift.Result<GameResult, NetworkError>) -> Void) {
        let urlString: String
        if let nextPage = nextPage {
            urlString = nextPage
        } else {
            urlString = APIConstants.baseURL + "?key=" + APIConstants.apiKey
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString)))
            return
        }
        
        performRequest(url: url, completion: completion)
    }
    
    func fetchSingleGame(id: Int, completion: @escaping (Swift.Result<GameDetail, NetworkError>) -> Void) {
        var components = URLComponents(string: APIConstants.baseURL)!
        components.path.append("/\(id)")
        components.queryItems = [URLQueryItem(name: "key", value: APIConstants.apiKey)]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL(components.string ?? "")))
            return
        }
        
        performRequest(url: url, completion: completion)
    }
    
    func fetchScreenShots(id: Int, completion: @escaping (Swift.Result<ScreenShot, NetworkError>) -> Void) {
        var components = URLComponents(string: APIConstants.baseURL)!
        components.path.append("/\(id)/screenshots")
        components.queryItems = [URLQueryItem(name: "key", value: APIConstants.apiKey)]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL(components.string ?? "")))
            return
        }
        
        performRequest(url: url, completion: completion)
    }
    
    func fetchTrailers(id: Int, completion: @escaping (Swift.Result<Trailer, NetworkError>) -> Void) {
        var components = URLComponents(string: APIConstants.baseURL)!
        components.path.append("/\(id)/movies")
        components.queryItems = [URLQueryItem(name: "key", value: APIConstants.apiKey)]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL(components.string ?? "")))
            return
        }
        
        performRequest(url: url, completion: completion)
    }
    
    func fetchSearchGames(searchString: String, completion: @escaping (Swift.Result<Search, NetworkError>) -> Void) {
        var components = URLComponents(string: APIConstants.baseURL)!
        components.queryItems = [
            URLQueryItem(name: "key", value: APIConstants.apiKey),
            URLQueryItem(name: "search", value: searchString)
        ]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL(components.string ?? "")))
            return
        }
        
        print(url)
        performRequest(url: url, completion: completion)
    }
    
    func fetchRedditComment(id: Int, completion: @escaping (Swift.Result<RedditResponse, NetworkError>) -> Void){
        var components = URLComponents(string: APIConstants.baseURL)!
        components.path.append("/\(id)/reddit")
        components.queryItems = [URLQueryItem(name: "key", value: APIConstants.apiKey)]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL(components.string ?? "")))
            return
        }
        
        performRequest(url: url, completion: completion)
    }

    
}
