//
//  HomeViewController.swift
//  MySwiftTableApp
//
//  Created by Алексей on 31.01.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import UIKit
import VK_ios_sdk

class HomeViewController: UITableViewController {
    let cellId = "cellId"
    let wallModel = WallModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let completion: () -> Void = { [weak self] in
            self?.tableView.reloadData()
        }

        wallModel.getPosts(owner: .bankiRu, complition: completion)

        tableView.backgroundColor = .white
        setupNavigationBar()

        tableView.register(ContentCell.self, forCellReuseIdentifier: cellId)
    }

    private func setupNavigationBar() {
        navigationItem.title = "VK Wall"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallModel.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContentCell else {
            return UITableViewCell()
        }

        cell.wordLabel.text = wallModel.posts[indexPath.row].text
        cell.timeAndDateLabel.text = wallModel.posts[indexPath.row].date
        cell.authorNameLabel.text = wallModel.posts[indexPath.row].author
        cell.authorImageView.set(imageURL: wallModel.posts[indexPath.row].imageURL)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let safeArea = view.safeAreaInsets
        let safeAreaInsets = safeArea.left + safeArea.right
        let text = wallModel.posts[indexPath.row].text

        let approximateWidhthOfCellTextView = view.frame.width - TweetsCellConstantns.avatarSize - 3 * TweetsCellConstantns.sideOffset
            - safeAreaInsets
        let size = CGSize(width: approximateWidhthOfCellTextView, height: .greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let estimateFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let hight = estimateFrame.height + TweetsCellConstantns.avatarSize + 3 * TweetsCellConstantns.sideOffset

        return hight
    }

    // TODO: Header?

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header: UIView = .init()
//        header.backgroundColor = .lightGray
//
//        return header
//    }

//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Header"
//    }

}

