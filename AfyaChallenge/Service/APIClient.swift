//
//  APIClient.swift
//  AfyaChallengeServices
//
//  Created by Neylor Bagagi on 11/08/21.
//



import Foundation

public enum APIClientShowUpdatePeriod:String{
    case all
    case day
    case week
    case month
}

class APIClient {
    
    static let share = APIClient()
    
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
    private func apiRequest<T:Codable>(url:URL, type:T.Type, completion: @escaping (_ data:T?,_ response:URLResponse?,_ error:Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil,nil,error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data!)
                completion(decodedData,nil, nil)
            } catch let error {
                completion(nil,nil,error)
            }
        }.resume()
    }

    /// Returns shows index decoded data to ShowRequestResponse model
    /// - Parameters:
    ///     - page: Int
    /// - Returns:
    ///     - data: [ShowRequestResponse], I was using optional but, it's easier to return empty array for now
    ///     - error: Error?
    func getShows(forPage page:Int, completion: @escaping (_ data:[ShowRequestResponse],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/shows?page=\(page)"
        guard let urlRequest = URL(string: url) else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest, type:[ShowRequestResponse].self) { (data, response, error) in
            guard let data = data, error == nil else {
                completion([],error)
                return
            }
            completion(data,nil)
        }
    }
    
    /// Returns the id ofr shows 
    /// - Parameters:
    ///     - string: String
    /// - Returns:
    ///     - data: [Int], I was using optional but, it's easier to return empty array for now
    ///     - error: Error?
    func getShows(forString string:String, completion: @escaping (_ data:[ShowSearchRequestResponse],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/search/shows?q=\(string)"
        guard let urlRequest = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest, type:[ShowSearchRequestResponse].self) { (data, response, error) in
            guard let data = data, error == nil else {
                completion([],error)
                return
            }
            completion(data,nil)
        }
    }
    
    /// Returns a show decode to ShowResponseRequest model
    /// - Parameters:
    ///     - id: Int
    /// - Returns:
    ///     - data: ShowRequestResponse
    ///     - error: Error?
    func getShow(forId id:Int, completion: @escaping (_ data:ShowRequestResponse?,_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/shows/\(id)"
        guard let urlRequest = URL(string: url) else{
            completion(nil,APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest, type:ShowRequestResponse.self) { (data, response, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }
    }
    
    /// Returns all episodes from a show and decode then to EpisodeResponseRequest model
    /// - Parameters:
    ///     - id: Int
    /// - Returns:
    ///     - data: EpisodeResponseRequest
    ///     - error: Error?
    func getShowEpisodes(forShow id:Int, completion: @escaping (_ data:[EpisodeRequestResponse],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/seasons/\(id)/episodes"
        guard let urlRequest = URL(string: url) else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest, type:[EpisodeRequestResponse].self) { (data, response, error) in
            guard let data = data, error == nil else {
                completion([],error)
                return
            }
            completion(data,nil)
        }
    }
    
    /// A list of all images available for this show.
    /// The image type can be "poster", "banner", "background", "typography", or NULL in case of legacy unclassified images.
    /// - Parameters:
    ///     - id: Int
    /// - Returns:
    ///     - data: ImageResponseRequest
    ///     - error: Error?
    func getShowImages(forShow id:Int, completion: @escaping (_ data:[ImageRequestResponse],_ error:Error?) -> Void) {
        
        let url = "https://api.tvmaze.com/shows/\(id)/images"
        guard let urlRequest = URL(string: url) else{
            completion([],APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest, type:[ImageRequestResponse].self) { (data, response, error) in
            guard let data = data, error == nil else {
                completion([],error)
                return
            }
            completion(data,nil)
        }
    }
    
    /// A list of all shows in the TVmaze database and the timestamp when they were last updated.
    /// Updating a direct or indirect child of a show will also mark the show itself as updated.
    /// For example; creating, deleting or updating an episode or an episode's gallery item will
    /// mark the episode's show as updated. It's possible to filter the resultset to only include
    /// shows that have been updated in the past day (24 hours), week, or month.
    /// - Parameters:
    ///     - since: APIClientShowUpdatePeriod
    ///     - completion: data:[String:Int]?, error:Error?
    /// - Returns:
    ///     - data: [ImageResponseRequest]
    ///     - error: Error?
    func getShowUpdates(since:APIClientShowUpdatePeriod, completion: @escaping (_ data:[String:Int]?,_ error:Error?) -> Void) {
        
        var url = ""
        switch since {
        case .day:
            url = "https://api.tvmaze.com/updates/shows?since=day"
        case .week:
            url = "https://api.tvmaze.com/updates/shows?since=week"
        case .month:
            url = "https://api.tvmaze.com/updates/shows?since=month"
        default:
            url = "https://api.tvmaze.com/updates/shows"
        }
        
        guard let urlRequest = URL(string: url) else{
            completion(nil,APIClientError.invalidURL(reason: "Invalid URL: \(url)"))
            return
        }
        
        self.apiRequest(url: urlRequest, type:[String:Int].self) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }
    }
    
}
