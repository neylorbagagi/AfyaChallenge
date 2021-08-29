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
        /// Networking operation
        /// in case of Realm instance does not have the records for request page
        /// this process will get it from API
        let dispatchGroup = DispatchGroup()
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
    
    func getShows(byString string:String, completion: @escaping (_ data:[Show],_ error:Error?) -> Void){
   
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
       
        
//        let realmShows = realm.objects(Show.self).filter("name CONTAINS '\(string)'")
//        completion(Array(realmShows), nil)
        
        
        
        
        
        
        /// Networking operation
        /// in case of Realm instance does not have the records for request page
        /// this process will get it from API
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        var responseData:[ShowSearchRequestResponse] = []
        APIClient.share.getShows(forString: string) { (data, error) in
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
        
        //        var responseData:[ShowRequestResponse] = []
        //        dispatchGroup.enter()
        //        APIClient.share.getShows(forPage: page) { (data, error) in
        //            guard error == nil else{
        //                completion([],error)
        //                return
        //            }
        //            responseData = data
        //            dispatchGroup.leave()
        //        }
        //        dispatchGroup.wait()
        //        do {
        //            let shows = try Show.showsFromAPIResponse(responseData)
        //            saveShows(shows: shows)
        //            completion(Array(shows),nil)
        //        } catch let error {
        //            completion([],error)
        //        }
        
        
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
