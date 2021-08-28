//
//  ShowSearchRequestResponse.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 23/08/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation

struct ShowSearchRequestResponse: Codable {
    let score: Double
    let show: ShowRequestResponse
}
