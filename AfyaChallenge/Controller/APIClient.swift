//
//  APIClient.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation

class APIClient{
    
    enum APIClientError:Error{
        case invalidURL(reason: String)
    }
    
    /// This function is only responsible for execute the api requests
    /// - Parameters:
    ///     - url: `URL()`
    /// - Returns:
    ///     - data: Data?,
    ///     - response: Response?,
    ///     - error: Error?
    private func apiRequest(url:URL, completion: @escaping (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil,nil,APIClientError.invalidURL(reason: "Invalid URL: \(url.absoluteString)"))
                return
            }
            completion(data,response,nil)
            }.resume()
    }

    
    /// Returns shows index decoded data to ACShow model
    /// - Parameters:
    ///     - page: Int
    /// - Returns:
    ///     - data: [ACShow], I was using optional but, it's easier to return empty array for now
    ///     - error: Error?
    func getShows(forPage page:Int, completion: @escaping (_ data:[ACShow],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/shows?page=\(page)"
        guard let urlRequest = URL(string: url) else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest) { (data, response, error) in
            guard let data = data else{
                completion([],error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ACShow].self, from: data)
                completion(decodedData,nil)
            } catch let error {
                completion([],error)
            }
        }
    }
    
    /// Returns shows with query context
    /// - Parameters:
    ///     - query: String
    /// - Returns:
    ///     - data: [ACShow],
    ///     - error: Error?
    func getShows(byQuery query:String, completion: @escaping (_ data:[ACShow],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/search/shows?q=girls"
        guard let urlRequest = URL(string: url) else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest) { (data, response, error) in
            guard let data = data else{
                completion([],error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedQuery = try decoder.decode([ACQueryResponse].self, from: data)
                let decodedData = decodedQuery.map() {$0.show}
                
                completion(decodedData,nil)
            } catch let error {
                completion([],error)
            }
        }
    }
    
    /// Returns episodes from a show
    /// - Parameters:
    ///     - id: Int
    /// - Returns:
    ///     - data: [ACEpisode]
    ///     - error: Error?
    func getEpisodes(forShow id:Int, completion: @escaping (_ data:[ACEpisode],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/shows/\(id)/episodes"
        guard let urlRequest = URL(string: url) else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest) { (data, response, error) in
            guard let data = data else{
                completion([],error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ACEpisode].self, from: data)
                completion(decodedData,nil)
            } catch let error {
                completion([],error)
            }
        }
    }
    
}
