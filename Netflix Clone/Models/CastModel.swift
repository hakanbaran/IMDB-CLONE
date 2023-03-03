//
//  CastModel.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 2.03.2023.
//

import Foundation

struct CastModel: Codable {
    let id: Int?
    let cast: [Cast]?
}

struct Cast: Codable {
    let name: String?
    let profilePath: String?
    let character: String?
}
