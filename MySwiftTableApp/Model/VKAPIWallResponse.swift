//
//  VKAPIWallResponse.swift
//  MySwiftTableApp
//
//  Created by Алексей on 16.02.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import Foundation

struct WallResponseWrapped: Decodable { // TODO: CodingKeys
    let response: WallResponse
}

struct WallResponse: Decodable {
    let count
    let items: [WallItems]
    let groups: [Group]
}

struct WallItems: Decodable {
    let id: Int
    let fromId: Int // from_id"
    let ownerId: Int // "owner_id"
    let date: Double
    let text: String
}

struct Group: Decodable {
    let id: Int
    let name: String
    let type: String
    let photo50: String // "photo_50"
    let photo100: String // "photo_100"
}
