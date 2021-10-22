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
    let realm = try? Realm()
 
    
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
                dispatchGroup.leave()
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
        
        /// Networking operation
        /// in case of Realm instance does not have the records for request page
        /// this process will get it from API
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        var responseData:[ShowSearchRequestResponse] = []
        APIClient.share.getShows(forString: string) { (data, error) in
            guard error == nil else{
                completion([],error)
                dispatchGroup.leave()
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
    
    func getShows(byIdList list:[Int], completion: @escaping (_ data:[Show],_ error:Error?) -> Void){
   
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
//        let collection = realm.objects(Show.self)
//
//        let indexSet = IndexSet(list)
        
//        let response:[Show] = Array(realm.objects(Show.self).objects(at: IndexSet(list)))
        
        
        var response:[Show] = []
        
        for id in list {
            if let show = realm.object(ofType: Show.self, forPrimaryKey: id){
                response.append(show)
            }
        }
        
        if !response.isEmpty {
            completion(response,nil)
        }
        
        if response.count < list.count {
            
            /// Networking operation
            /// in case of Realm instance does not have the records for request page
            /// this process will get it from API
            
            /// parameter: remaining array contains show's id not found in realm
            let remaining = list.filter { id in !response.contains(where: { $0.id == id } ) }
            
            let group = DispatchGroup()
            var responseData:[ShowRequestResponse] = []
    
            for id in remaining {
                group.enter()
                APIClient.share.getShow(forId: id) { (data, error) in
                    guard error == nil,
                      let data = data else{
                        completion([],error)
                        group.leave()
                        return
                    }
                    responseData.append(data)
                    group.leave()
                }
            }
            group.wait()
    
            do {
                let shows = try Show.showsFromAPIResponse(responseData)
                saveShows(shows: shows)
                completion(Array(shows),nil)
            } catch let error {
                completion([],error)
            }
            
        }
    }
    
    func getFavourites(completion: @escaping (_ data:[Show],_ error:Error?) -> Void){
   
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        let response = realm.objects(Show.self).filter("favourite == true")
        completion(Array(response),nil)

    }
    
    func getRating(completion: @escaping (_ data:[Show],_ error:Error?) -> Void){
   
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        let response = realm.objects(Show.self).sorted(byKeyPath: "rating", ascending: false)
        for show in response {
            print(show.rating)
        }
        completion(Array(response),nil)

    }
    
    func getUpdates(completion: @escaping (_ data:[Show],_ error:Error?) -> Void){
   
        
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        let response = realm.objects(Show.self).sorted(byKeyPath: "updated", ascending: false)
        
        completion(Array(response),nil)
        

        /// Networking operation
        /// in case of Realm instance does not have the records for request page
        /// this process will get it from API
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        var updates:[String:Int] = [:]
        APIClient.share.getShowUpdates(since: .day) { (data, error) in
            guard error == nil,
              let data = data else {
                completion([],error)
                dispatchGroup.leave()
                return
            }
            updates = data
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        
        let ids:[Int] = updates.keys.map { (Int($0) ?? 0) }

        
        self.getShows(byIdList: ids) { (data, error) in
            guard error == nil else{
                completion([],error)
                return
            }
            
            completion(data.sorted(by: { TimeInterval($0.updated) > TimeInterval($1.updated) }),nil)
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
                dispatchGroup.leave()
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
    
    func getImages(byShow show:Show, completion: @escaping (_ data:String, _ error:Error?) -> Void){
        
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        let dispatchGroup = DispatchGroup()
        var responseData:[ImageRequestResponse] = []
        dispatchGroup.enter()
        APIClient.share.getShowImages(forShow: show.id) { (data, error) in
            guard error == nil else{
                completion("",error)
                dispatchGroup.leave()
                return
            }
            responseData = data
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        
        if responseData.count > 0 {
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
                completion(images.first ?? "",nil)
            } catch let error {
                completion("",error)
            }
        }
        
    }
    
    func updateShowFavouriteStatus(show:Show){
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        try! realm.write{
            show.favourite.toggle()
            print(show.favourite)
        }
    }
    
    private func saveShows(shows:List<Show>){
        guard let realm = try? Realm() else{
            fatalError("Could not to load Realm")
        }
        
        var updateList:[Show] = []
        for show in shows {
            if let currentShow = realm.object(ofType: Show.self, forPrimaryKey: show.id) {
                updateList.append(currentShow.updateVersion(update: show))
            } else {
                updateList.append(show)
            }
        }
        
        
        try! realm.write{
            realm.add(updateList, update: Realm.UpdatePolicy.modified)
        }
    }
    
}
