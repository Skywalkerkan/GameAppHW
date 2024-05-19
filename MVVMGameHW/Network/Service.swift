//
//  Service.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import Foundation

protocol GameServiceProtocol{
    func fetchListOfGames(completion: @escaping (Swift.Result<GameResult, NetworkError>) -> Void)
}

class GameService: GameServiceProtocol{
   
    private init() {}
    
    static let shared = GameService()
    
    func fetchListOfGames(completion: @escaping (Swift.Result<GameResult, NetworkError>) -> Void) {
        let urlString = APIConstants.baseURL + "?key=" + APIConstants.apiKey
                
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gameResult = try decoder.decode(GameResult.self, from: data)
                completion(.success(gameResult))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }

}
