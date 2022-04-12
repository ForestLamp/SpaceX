//
//  Parser.swift
//  SpaceX
//
//  Created by Alex Ch. on 11.04.2022.
//

import UIKit

class Parser {
    
    private let urlString = Api().baseURL
    
    func getData(){
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print("Ошибка запроса \(error)")
            }
            guard let data = data else {return}
            do {
                let rokets = try JSONDecoder().decode([Roket].self, from: data)
                print(rokets)
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
