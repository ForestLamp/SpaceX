//
//  Parser.swift
//  SpaceX
//
//  Created by Alex Ch. on 11.04.2022.
//

import UIKit

class NetworkService {
    
    private let baseURL = "https://api.spacexdata.com/v4/rockets"
    
    func fetchData(completion: @escaping (Result<[Rocket]?, Error>) -> Void ){
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Response error \(error)")
            }
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode([Rocket].self, from: data)
                completion(.success(json))
            } catch {
                print("Parsing error: \(error)")
            }
        }.resume()
    }
}
