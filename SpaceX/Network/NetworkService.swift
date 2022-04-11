//
//  NetworkService.swift
//  SpaceX
//
//  Created by Alex Ch. on 11.04.2022.
//

import Foundation

class NetworkService {
    
    
    let urlString = "https://api.spacexdata.com/v4/rockets"
    func request(urlString: String, completion: @escaping (Result<Data, Error>)-> Void){
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }
}
