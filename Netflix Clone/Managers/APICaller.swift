//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 14.12.2022.
//

import Foundation

struct Constants {
    static let APIKey = "key=3eb740bc8fc93686e023441eb0718ab1"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPIKey = "key=AIzaSyBjnlcm0Fi1XWxFP5wNOaANuZlTf-E-6ro"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}


enum APIError: Error {
    case failedTogetData
    case failedToCasts
}

class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_\(Constants.APIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
//                print("Get Data...")
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_\(Constants.APIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_\(Constants.APIKey)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_\(Constants.APIKey)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                

            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_\(Constants.APIKey)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> ()) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_\(Constants.APIKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    
    func search(with query: String,completion: @escaping (Result<[Title], Error>) -> ()) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_\(Constants.APIKey)&query=\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getMovietoYoutube(with query: String,completion: @escaping (Result<VideoElement, Error>) -> ()) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&\(Constants.youtubeAPIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                print(results.items[0])
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
    func getMovieCasts(with query: Int, with mediaType: String, completion: @escaping (Result<[Cast], Error>) -> ()) {
        
//        guard let query = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/\(mediaType)/\(query)/credits?api_\(Constants.APIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(CastModel.self, from: data)
                
//                guard let result = result else {return}
                
                completion(.success(result.cast ?? []))
//                print(result)
                
            } catch {
                completion(.failure(APIError.failedToCasts))
            }
        }
        task.resume()
         
    }
    
}
