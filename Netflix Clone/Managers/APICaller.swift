//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 14.12.2022.
//

import Foundation

struct Constants {
    static let APIKey = "3eb740bc8fc93686e023441eb0718ab1"
    static let baseURL = "https://api.themoviedb.org"
}

class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.APIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
                
            }
            
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
    
}
