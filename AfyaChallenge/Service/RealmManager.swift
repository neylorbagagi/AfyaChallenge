//
//  RealmManager.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 31/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation
import RealmSwift


class Pet: Object {
    @Persisted var name:String
    
    convenience init(name:String) {
        self.init()
        self.name = name
    }
}

class RealmManager {
    
    static let shared = RealmManager()
    
    func getShows(forPage page:Int, completion: @escaping (_ data:[Show], _ error:Error?) -> Void){
        
        /// TVMaza pagination brings 250 registers each request
        let paginationLimit = 250
        
        let lastIdForPage:Int = page * paginationLimit
        let firstIfForPage:Int = lastIdForPage - paginationLimit
        
        let realm = try! Realm()
        var shows = realm.objects(Show.self).filter("id > \(firstIfForPage) AND id <= \(lastIdForPage)")
        
        if shows.count > 0 {
            completion(Array(shows),nil)
        }
        
        APIClient.shared.getShows(forPage:page) { (data,error) in
            guard error == nil else{
                completion([],error)
                return
            }
            
            let decodedShows = Show.showsFromResponse(data: data)
            
            try! realm.write {
                for show in decodedShows{
                    realm.add(show, update: Realm.UpdatePolicy.modified)
                }
                
                shows = realm.objects(Show.self).filter("id > \(firstIfForPage) AND id <= \(lastIdForPage)")
                completion(Array(shows),nil)
            }
            
        }
        
    }
    
    
    
    func hello() {
        let realm = try! Realm()
        
        let pet = Pet(name: "Gato")
        try! realm.write() {
            realm.add(pet)
        }
        
        print("hello")
    }
    
    
}
