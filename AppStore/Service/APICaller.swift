//
//  APICaller.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import Foundation
class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://rss.applemarketingtools.com/api/v2/us/apps"
    }
    enum APIError : Error {
        case failedToGetData
    }
    
    public func getFreeApps(completion: @escaping (Result<Feed, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/top-free/50/apps.json"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AppModel.self, from: data)
                    completion(.success(result.feed))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getPaidApps(completion: @escaping (Result<Feed, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/top-paid/50/apps.json"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AppModel.self, from: data)
                    completion(.success(result.feed))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    enum HTTPMethod : String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else { return }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        completion(request)
    }
}
