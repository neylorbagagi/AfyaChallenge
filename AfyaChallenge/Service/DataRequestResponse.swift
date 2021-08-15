//
//  ShowRequestResponse.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation

// MARK: - ShowElement
struct ShowResponseRequest: Codable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let runtime: Int?
    let averageRuntime: Int
    let premiered: String
    let officialSite: String?
    let schedule: ScheduleResponseRequest
    let rating: RatingResponseRequest
    let weight: Int
    let network: NetworkResponseRequest?
    let webChannel: NetworkResponseRequest?
    let image: ImageResponseRequest
    let summary: String
    let updated: Int

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, officialSite, schedule, rating, weight, network, webChannel, image, summary, updated
    }
    
    // MARK: - Image
    struct ImageResponseRequest: Codable {
        let medium, original: String
    }

    // MARK: - Network
    struct NetworkResponseRequest: Codable {
        let name: String
    }

    // MARK: - Rating
    struct RatingResponseRequest: Codable {
        let average: Double?
    }

    // MARK: - Schedule
    struct ScheduleResponseRequest: Codable {
        let time: String
        let days: [String]
    }
}



