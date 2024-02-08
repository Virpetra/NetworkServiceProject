//
//  NetworkManager.swift
//  NetworkServiceProject
//
//  Created by Mehmet Said Dede on 8.02.2024.
//

import Foundation

class NetworkManager : ObservableObject {
    
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void ) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&locale=en") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
}


