//
//  VKAPIGroupsResponse.swift
//  MySwiftTableApp
//
//  Created by Алексей on 20.03.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import Foundation

struct GroupsResponseWrapped: Decodable { 
    let response: [GroupResponse]
}

struct GroupResponse: Decodable {
    let id: Int
    let name: String
    let photo50: String
}
