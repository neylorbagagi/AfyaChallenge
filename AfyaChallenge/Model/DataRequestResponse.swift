//
//  ShowRequestResponse.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation

// ACShow Model
struct ACShow:Codable{
    let id:Int
    let name:String
    let image:ACPoster?
    let schedule:ACSchedule
    let genres:[String]
    let summary:String
    let favourite:Bool = false
}

// ACEpisode Model
struct ACEpisode:Codable{
    let id:Int
    let name:String
    let season:Int
    let number:Int
    let summary:String
    let image:ACPoster
}

// ACQueryResponse Model
struct ACQueryResponse:Codable{
    let score:Double
    let show:ACShow
}

// Common
struct ACSchedule:Codable{
    let time:String
    let days:[String]
}

struct ACPoster:Codable{
    let medium:String
}
