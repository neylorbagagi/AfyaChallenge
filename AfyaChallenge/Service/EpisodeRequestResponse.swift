//
//  EpisodeRequestResponse.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 14/08/21.
//

import Foundation

struct EpisodeRequestResponse: Codable {
    let id: Int
    let url: String
    let name: String
    let season, number: Int
    let type: String
    let airdate: String
    let airtime: String
    let airstamp: String
    let runtime: Int
    let image: EpisodeRequestResponseImage
    let summary: String

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, image, summary
    }
    
    struct EpisodeRequestResponseImage: Codable {
        let medium, original: String
    }
}




