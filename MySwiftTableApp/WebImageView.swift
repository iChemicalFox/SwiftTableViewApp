//
//  WebImageView.swift
//  MySwiftTableApp
//
//  Created by Алексей on 21.03.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    self?.image = UIImage(data: data)
                }
            }
        }
        dataTask.resume()
    }
}
