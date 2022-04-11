//
//  DataFetcher.swift
//  SpaceX
//
//  Created by Alex Ch. on 11.04.2022.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchRockets(urlString: String, response: @escaping (Rocket?) -> Void) {
        
        networkService.request(urlString: urlString) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let rockets = try JSONDecoder().decode(Rocket.self, from: data)
                    response(rockets)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
