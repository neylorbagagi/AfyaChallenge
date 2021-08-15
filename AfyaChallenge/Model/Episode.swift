//
//  Episode.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 14/08/21.
//

import Foundation
import RealmSwift

class Episode:Object {
    
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var season: Int
    @Persisted var number: Int
    @Persisted var type: String
    @Persisted var airdate: String
    @Persisted var airtime: String
    @Persisted var airstamp: String
    @Persisted var runtime: Int
    @Persisted var images: Map<String,String>
    @Persisted var summary: String
    
    convenience init(_ object:EpisodeRequestResponse) throws {
        self.init()
        self.id = object.id
        self.name = object.name
        self.season = object.season
        self.number = object.number
        self.type = object.type
        self.airdate = object.airdate
        self.airtime = object.airtime
        self.airstamp = object.airstamp
        self.runtime = object.runtime
        self.images["medium"] = object.image.medium
        self.images["original"] = object.image.original
        self.summary = object.summary
    }
    
    static func episodesFromAPIResponse(_ objects:[EpisodeRequestResponse]) throws -> List<Episode> {
        let response:List<Episode> = List<Episode>()
        for item in objects {
            response.append(try Episode(item))
        }
        return response
    }
}
