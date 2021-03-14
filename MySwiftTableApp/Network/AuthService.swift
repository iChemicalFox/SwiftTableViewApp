//
//  AuthService.swift
//  MySwiftTableApp
//
//  Created by Алексей on 15.02.2021.
//  Copyright © 2021 Алексей. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    private let appId = "7747839"
    private let vkSdk: VKSdk

    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)

        super.init()

        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    weak var delegate: AuthServiceDelegate?

    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [weak delegate] (state, error) in

            switch state {
            case .initialized:
                VKSdk.authorize(scope)

            case .authorized:
                delegate?.authServiceSignIn()

            default:
                delegate?.authServiceSignInDidFail()
                fatalError(error!.localizedDescription)
            }
        }
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
