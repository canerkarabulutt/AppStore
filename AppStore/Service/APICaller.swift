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
        static let mainURL = "https://rss.applemarketingtools.com/api/v2/us/apps"
        static let baseURL = "https://itunes.apple.com"
    }
    enum APIError : Error {
        case failedToGetData
    }
    //MARK: - API App Caller
    public func getFreeApps(completion: @escaping (Result<Feed, Error>) -> Void) {
        createRequest(with: URL(string: Constants.mainURL + "/top-free/50/apps.json"), type: .GET) { request in
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
        createRequest(with: URL(string: Constants.mainURL + "/top-paid/50/apps.json"), type: .GET) { request in
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
    //MARK: - API Search Caller
    public func search(with term: String, completion: @escaping (Result<SearchModel, Error>) -> Void) {
        let queryParameters = ["term": term, "entity": "software"]
        guard let baseURL = URL(string: Constants.baseURL) else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        let searchURL = baseURL.appendingPathComponent("search")
        guard var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true) else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalURL = components.url else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        createRequest(with: finalURL, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SearchModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - API App Details Caller
    public func getAppDetails(with id: String, completion: @escaping (Result<AppDetailModel, Error>) -> Void) {
        let queryParameters = ["id": id]
        guard let baseURL = URL(string: Constants.baseURL) else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        let lookupURL = baseURL.appendingPathComponent("lookup")
        guard var components = URLComponents(url: lookupURL, resolvingAgainstBaseURL: true) else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalURL = components.url else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        createRequest(with: finalURL, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AppDetailModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - API App Screenshots Caller
    public func getScreenshots(with id: String, completion: @escaping (Result<AppDetailModel, Error>) -> Void) {
        let queryParameters = ["id": id]
        guard let baseURL = URL(string: Constants.baseURL) else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        let lookupURL = baseURL.appendingPathComponent("lookup")
        guard var components = URLComponents(url: lookupURL, resolvingAgainstBaseURL: true) else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalURL = components.url else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        createRequest(with: finalURL, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AppDetailModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - API App Ratings Caller
    public func getRatingData(with id: String, completion: @escaping (Result<RatingModel, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/rss/customerreviews/page=1/id=\(id)/sortbt=mostrecent/json?=en&cc=us"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RatingModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - API Header Caller
    public func getHeaderData(completion: @escaping (Result<[HeaderModel], Error>) -> Void) {
        createRequest(with: URL(string: "https://api.letsbuildthatapp.com/appstore/social"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode([HeaderModel].self, from: data)
                    completion(.success(result))
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
    //MARK: - API Request
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else { return }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        completion(request)
    }
}
