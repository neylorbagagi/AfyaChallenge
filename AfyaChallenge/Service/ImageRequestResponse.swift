//
//  ImageResponseRequest.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 14/08/21.
//

import Foundation

struct ImageRequestResponse: Codable {
    let id: Int
    let type: String
    let main: Bool
    let resolutions: Resolutions
}

struct Resolutions: Codable {
    let original: MataData
    let medium: MataData?
}

struct MataData: Codable {
    let url: String
    let width, height: Int
}





