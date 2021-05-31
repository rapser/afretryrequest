//
//  LoginViewModel.swift
//  AFRetryRequest
//
//  Created by alireza.a on 11/10/2020.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import Foundation
class LoginViewModel {
    func login(apiKey: String, secretKey: String) {
//        let parameters = ["grant_type": "client_credentials", "client_id": apiKey, "client_secret": secretKey]
        
        let parameters = ["platformCode": "ios", "documentNumber": apiKey, "password": secretKey]
        NetworkManager.shared.authorize(parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                if let token = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])?["token"] as? String, let refreshToken = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])?["refreshToken"] as? String {
                    UserDefaultsManager.shared.signIn(apiKey: apiKey, secretKey: secretKey, token: token, refresh: refreshToken)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
