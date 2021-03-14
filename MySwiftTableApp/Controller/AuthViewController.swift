//
//  AuthViewController.swift
//  MySwiftTableApp
//
//  Created by Алексей on 15.02.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    let authButton: UIButton = .init(type: .system)
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        authService = SceneDelegate.shared().authService

        navigationItem.title = "VK Auth"
        setupViews()
    }

    @objc func authorization() {
        authService.wakeUpSession()
    }

    func setupViews() {
        view.backgroundColor = .white
        authButton.backgroundColor = .systemBlue
        authButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.setTitle("Тук-тук", for: .normal)
        authButton.setTitleColor(.white, for: .normal)

        view.addSubview(authButton)
        NSLayoutConstraint.activate([
            authButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20),
            authButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 20),
            authButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -80),
            authButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 80)
        ])

        authButton.addTarget(self, action: #selector(authorization), for: .touchUpInside)
    }
}
