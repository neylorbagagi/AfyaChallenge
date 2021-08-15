//
//  RealmManager.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 14/08/21.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let share = RealmManager()
    
    func getShows(byPage page:Int, completion: @escaping (_ data:[Show],_ error:Error?) -> Void){
   
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        
        /// Realm operation
        /// If this processo is succeful return to main task
        let dispatchGroup = DispatchGroup()
        let maxItems = 250
        let minId = (page*maxItems) + 1
        let maxId = (page+1) * maxItems
        
        let realmShows = realm.objects(Show.self).filter("id >= \(minId) AND id <= \(maxId)")
        if realmShows.count > 0{
            completion(Array(realmShows), nil)
            return
        }
        
        
        /// Networking operation
        /// in case of Realm instance does not have the records for request page
        /// this process will get it from API
        var responseData:[ShowRequestResponse] = []
        dispatchGroup.enter()
        APIClient.share.getShows(forPage: page) { (data, error) in
            guard error == nil else{
                completion([],error)
                return
            }
            responseData = data
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        
        
        
        do {
            let shows = try Show.showsFromAPIResponse(responseData)
            saveShows(shows: shows)
            completion(Array(shows),nil)
        } catch let error {
            completion([],error)
        }
        
        
    }
    
    func getEpisodes(byShow show:Show, completion: @escaping (_ data:[Episode], _ error:Error?) -> Void) -> Show {
        
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        let dispatchGroup = DispatchGroup()
        var responseData:[EpisodeRequestResponse] = []
        dispatchGroup.enter()
        APIClient.share.getShowEpisodes(forShow: show.id) { (data, error) in
            guard error == nil else{
                completion([],error)
                return
            }
            responseData = data
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        
        do {
            let episodes = try Episode.episodesFromAPIResponse(responseData)
            try! realm.write{
                show.episodes = episodes
                realm.add(show)
            }
            completion(Array(episodes),nil)
            return show
        } catch let error {
            completion([],error)
            return show
        }
    }
    
    func getImages(byShow show:Show, completion: @escaping (_ data:String, _ error:Error?) -> Void) -> Show {
        
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        let dispatchGroup = DispatchGroup()
        var responseData:[ImageRequestResponse] = []
        dispatchGroup.enter()
        APIClient.share.getShowImages(forShow: show.id) { (data, error) in
            guard error == nil else{
                completion("",error)
                return
            }
            responseData = data
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        
        do {
            var images:[String] = []
            let backgroundImages = responseData.filter({$0.type == "background"})
            for image in backgroundImages{
                images.append(image.resolutions.original.url)
            }
            
            try realm.write{
                show.images["background"] = images.first
                realm.add(show)
            }
            completion(images.first!,nil)
            return show
        } catch let error {
            completion("",error)
            return show
        }
    }
    
    private func saveShows(shows:List<Show>){
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        try! realm.write{
            realm.add(shows, update: Realm.UpdatePolicy.modified)
        }
    }
    
}
