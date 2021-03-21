//
//  VKAPIManager.swift
//  MySwiftTableApp
//
//  Created by Алексей on 15.02.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import Foundation

final class VKAPIManager {
    private let network = NetworkManager()

    func getWallPosts(ownerId: String, count: String, filter: String, extended: String, response: @escaping (WallResponse?) -> Void) {
        let params = ["owner_id": "\(ownerId)", "count": "\(count)", "filter": "\(filter)", "extendet": "\(extended)"]
        network.request(method: .getWall, params: params) { (data, error) in
            if let error = error {
                print("Data error: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJson(type: WallResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }

    func getGroupInfo(groupId: Int, response: @escaping ([GroupResponse]?) -> Void) {
        let params = ["group_id": "\(groupId)"]
        network.request(method: .getById, params: params) { (data, error) in
            if let error = error {
                print("Data error: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJson(type: GroupsResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
}

// MARK: - Decode

extension VKAPIManager {
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }

        return response
    }
}

// MARK: - VKAPIMethodsList

enum VKAPIMethodsList: String {
    case getWall = "/method/wall.get"
    case getById = "/method/groups.getById"
}
