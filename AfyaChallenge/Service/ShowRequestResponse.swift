//
//  ShowRequestResponse.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 11/08/21.
//

import Foundation

// MARK: - ShowElement
struct ShowRequestResponse: Codable {
    let id: Int
    let url: String?
    let name: String
    let type: String?
    let language: String?
    let genres: [String]
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: ShowRequestResponseSchedule
    let rating: ShowRequestResponseRating
    let weight: Int?
    let network, webChannel: ShowRequestResponseNetwork?
    let image: ShowRequestResponseImage?
    let summary: String?
    let updated: Int?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, officialSite, schedule, rating, weight, network, webChannel, image, summary, updated
    }
    
    // MARK: - Image
    struct ShowRequestResponseImage: Codable {
        let medium, original: String?
    }

    // MARK: - Network
    struct ShowRequestResponseNetwork: Codable {
        let name: String
    }

    // MARK: - Rating
    struct ShowRequestResponseRating: Codable {
        let average: Double?
    }

    // MARK: - Schedule
    struct ShowRequestResponseSchedule: Codable {
        let time: String
        let days: [String]
    }
}


