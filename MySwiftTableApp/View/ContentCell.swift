//
//  ContentCell.swift
//  MySwiftTableApp
//
//  Created by Алексей on 31.01.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    let wordLabel: UILabel = {
        let label: UILabel = .init()

        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var authorImageView: WebImageView = {
        let imageView: WebImageView = .init()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let authorNameLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let timeAndDateLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    func setupViews() {
        backgroundColor = .clear

        self.contentView.addSubview(authorImageView)
        NSLayoutConstraint.activate([
            authorImageView.leftAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor, constant: TweetsCellConstantns.sideOffset),
            authorImageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: TweetsCellConstantns.sideOffset),
            authorImageView.heightAnchor.constraint(equalToConstant: TweetsCellConstantns.avatarSize),
            authorImageView.widthAnchor.constraint(equalToConstant: TweetsCellConstantns.avatarSize)
        ])

        self.contentView.addSubview(authorNameLabel)
        NSLayoutConstraint.activate([
            authorNameLabel.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: TweetsCellConstantns.sideOffset),
            authorNameLabel.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor, constant: -TweetsCellConstantns.sideOffset),
            authorNameLabel.bottomAnchor.constraint(equalTo: authorImageView.centerYAnchor, constant: 0)
         ])

        self.contentView.addSubview(timeAndDateLabel)
        NSLayoutConstraint.activate([
            timeAndDateLabel.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: TweetsCellConstantns.sideOffset),
            timeAndDateLabel.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor, constant: -TweetsCellConstantns.sideOffset),
            timeAndDateLabel.topAnchor.constraint(equalTo: authorImageView.centerYAnchor, constant: 0)
        ])

        self.contentView.addSubview(wordLabel)
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 0),
            wordLabel.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: TweetsCellConstantns.sideOffset),
            wordLabel.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor, constant: -TweetsCellConstantns.sideOffset),
//            wordLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -TweetsCellConstantns.sideOffset)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
