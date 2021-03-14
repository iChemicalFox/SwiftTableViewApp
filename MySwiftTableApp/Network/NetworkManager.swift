//
//  NetworkManager.swift
//  MySwiftTableApp
//
//  Created by Алексей on 31.01.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import Foundation

protocol Networking {
    func request(method: VKAPIMethodsList, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkManager: Networking {
    private let authService: AuthService

    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
       
    func request(method: VKAPIMethodsList, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = "5.92"
        let url = self.url(from: method, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
       
    private func url(from method: VKAPIMethodsList, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.rawValue
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
