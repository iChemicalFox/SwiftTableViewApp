//
//  WallModel.swift
//  MySwiftTableApp
//
//  Created by Алексей on 16.02.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import Foundation

final class WallModel {
    var posts: [Post] = .init()
    private let api = VKAPIManager()

    func getPosts(owner: GroupsId, complition: @escaping () -> Void) {
        var groupName = "Test"
        var iconURL = ""

        api.getGroupInfo(groupId: owner.rawValue) { (groupResponse) in
            guard let groupResponse = groupResponse else { return }
            if let name = groupResponse.first?.name {
                groupName = name
            }

            if let url = groupResponse.first?.photo50 {
                iconURL = url
            }
        }

        api.getWallPosts(ownerId: "-\(owner.rawValue)", count: "25", filter: "owner", extended: "1") { (wallResponse) in
            guard let wallResponse = wallResponse else { return }
            _ = wallResponse.items.map({ (wallItem) in
                let date = Date(timeIntervalSince1970: wallItem.date)
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "FET")
                dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
                dateFormatter.locale = Locale(identifier: "ru_RU")
                let stringDate = dateFormatter.string(from: date)

                self.posts.append(Post(text: wallItem.text, author: groupName, date: stringDate, groupIconURL: iconURL))
            })
            complition()
        }
    }
}

extension WallModel {
    enum GroupsId: Int {
        case bankiRu = 17032179
        case spbLive = 49684148
    }
}
