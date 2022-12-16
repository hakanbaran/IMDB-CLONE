//
//  Tv.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 16.12.2022.
//

import Foundation

struct TrendingTvResponse: Codable {
    
    let results : [Tv]
    
}

struct Tv: Codable{
    let id : Int
    let media_type : String?
    let original_name : String?
    let original_title : String?
    let poster_path : String?
    let overview : String?
    let release_data : String?
    let vote_average : Double
}
