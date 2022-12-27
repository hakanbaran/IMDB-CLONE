//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 27.12.2022.
//

import Foundation



struct YoutubeSearchResponse: Codable {
    
    let items : [VideoElement]
    
}

struct VideoElement : Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId : String
}
