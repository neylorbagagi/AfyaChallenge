//
//  Show.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 31/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import RealmSwift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let show = try? newJSONDecoder().decode(Show.self, from: jsonData)


/// TODO: UNDERsTAND decode for class https://stackoverflow.com/questions/29472935/cannot-decode-object-of-class
import Foundation

class Show:Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var url: String
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var language: String
    @Persisted var genres: List<String>
    @Persisted var status: String
    @Persisted var runtime: Int?
    @Persisted var averageRuntime: Int
    @Persisted var premiered: String
    @Persisted var officialSite: String?
    //@Persisted var schedule: Schedule?
    @Persisted var rating: Double?
    @Persisted var weight: Int
    @Persisted var network: String?
    @Persisted var webChannel: String?
    //@Persisted var image: Poster
    @Persisted var summary: String
    @Persisted var updated: Int
    @Persisted var favourite: Bool
    //schedule: Schedule?, image: Poster,
    init(id: Int, url: String, name: String, type: String, language: String, genres: List<String>, status: String, runtime: Int?, averageRuntime: Int, premiered: String, officialSite: String?,  rating: Double?, weight: Int, network: String?, webChannel: String?, summary: String, updated: Int) {
        super.init()
        self.id = id
        self.url = url
        self.name = name
        self.type = type
        self.language = language
        self.genres = genres
        self.status = status
        self.runtime = runtime
        self.averageRuntime = averageRuntime
        self.premiered = premiered
        self.officialSite = officialSite
        //self.schedule = schedule
        self.rating = rating
        self.weight = weight
        self.network = network
        self.webChannel = webChannel
        //self.image = image
        self.summary = summary
        self.updated = updated
        self.favourite = false
    }
    
    convenience init(fromResponse object:ShowResponseRequest) {
        
        //let newSchedule = Schedule(time:object.schedule.time, days: object.schedule.days)
        //let newPoster = Poster(medium: object.image.medium, original: object.image.original)
        
        self.init(id: object.id,
                  url: object.url,
                  name: object.name,
                  type: object.type,
                  language: object.language,
                  genres: realmListFromArray(object.genres),
                  status: object.status,
                  runtime: object.runtime,
                  averageRuntime: object.averageRuntime,
                  premiered: object.premiered,
                  officialSite: object.officialSite,
                  //schedule: newSchedule,
                  rating: object.rating.average,
                  weight: object.weight,
                  network: object.network?.name,
                  webChannel: object.network?.name,
                  //image: newPoster,
                  summary: object.summary,
                  updated: object.updated)
        
    }
    
    static func showsFromResponse(data:[ShowResponseRequest]) -> [Show] {
        var response:[Show] = []
        for item in data{
            response.append(Show(fromResponse: item))
        }
        return response
    }
    
    

}

// MARK: - Image
class Poster: Object {
    @Persisted var medium: String
    @Persisted var original: String
    @Persisted var wide: String

    init(medium: String, original: String) {
        self.medium = medium
        self.original = original
        self.wide = ""
    }
}


// MARK: - Schedule

//class Schedule: Object {
//    @Persisted var time: String
//    @Persisted var days: List<String>
//    
//    private init(time:String,days:List<String>) {
//        self.time = time
//        self.days = days
//    }
//    
//    convenience init(time:String,days:[String]) {
//        self.init(time:time,
//                  days:realmListFromArray(days))
//    }
//}

private func realmListFromArray(_ array:[String]) -> List<String> {
    var response = List<String>()
    
    for item in array{
        response.append(item)
    }
    
    return response
}







