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
    var imageHighlight:ACPoster?
    let schedule:ACSchedule
    let genres:[String]
    let summary:String?
    var favourite:Bool = false

    init(show:ACShow,imageHighlight:ACPoster) {
        self.id = show.id
        self.name = show.name
        self.image = show.image
        self.imageHighlight = imageHighlight
        self.schedule = show.schedule
        self.genres = show.genres
        self.summary = show.summary
        self.favourite = show.favourite
    }
    
}

// ACEpisode Model
struct ACEpisode:Codable{
    let id:Int
    let name:String
    let season:Int
    let number:Int
    let summary:String?
    let image:ACPoster?
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




// ACUpdates
struct ACUpdates:Codable {
    let id:String
    let timestamp:String
}
