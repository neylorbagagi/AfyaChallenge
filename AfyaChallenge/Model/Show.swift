//
//  Show.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 13/08/21.
//

import Foundation
import RealmSwift

class Show:Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var language: String?
    @Persisted var genres: List<String>
    @Persisted var status: String
    @Persisted var runtime: Int?
    @Persisted var averageRuntime: Int
    @Persisted var premiered: String
    @Persisted var scheduleTime: String
    @Persisted var scheduleDays: List<String>
    @Persisted var rating: Double?
    @Persisted var weight: Int
    @Persisted var network:String
    @Persisted var webChannel:String
    @Persisted var images: Map<String,String>
    @Persisted var summary: String
    @Persisted var updated: Int
    @Persisted var favourite: Bool
    @Persisted var episodes: List<Episode>
    
    convenience init(_ object:ShowRequestResponse) throws {
        self.init()
        self.id = object.id
        self.name = object.name
        self.type = object.type ?? "Unknow"
        self.language = object.language ?? "Unknow"
        self.genres = Self.arrayToList(object.genres)
        self.status = object.status ?? "Unknow"
        self.runtime = object.runtime ?? 0
        self.averageRuntime = object.averageRuntime ?? 0 
        self.premiered = object.premiered ?? "Unknow"
        self.scheduleTime = object.schedule.time
        self.scheduleDays = Self.arrayToList(object.schedule.days)
        self.rating = object.rating.average ?? 0.0
        self.weight = object.weight ?? 0
        self.network = object.network?.name ?? "Unknow"
        self.webChannel = object.webChannel?.name ?? "Unknow"
        self.images["medium"] = object.image.medium
        self.images["original"] = object.image.original
        self.summary = object.summary ?? "Unknow"
        self.updated = object.updated ?? 0
        self.favourite = false
        self.episodes = List<Episode>()
    }
    
    private static func arrayToList<T>(_ array:Array<T>) -> List<T> {
        let list = List<T>()
        for item in array {
            list.append(item)
        }
        return list
    }
    
    static func showsFromAPIResponse(_ objects:[ShowRequestResponse]) throws -> List<Show> {
        let response:List<Show> = List<Show>()
        for item in objects {
            response.append(try Show(item))
        }
        return response
    }
}


