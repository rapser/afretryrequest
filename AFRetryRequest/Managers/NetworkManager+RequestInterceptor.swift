//
//  NetworkManager+RequestInterceptor.swift
//  AFRetryRequest
//
//  Created by alireza.a on 11/10/2020.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import Alamofire
extension NetworkManager: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = UserDefaultsManager.shared.getToken() else {
            completion(.success(urlRequest))
            return
        }
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("\nretried; retry count: \(request.retryCount)\n")
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let apiKey = UserDefaultsManager.shared.getUserCredentials().apiKey,
            let secretKey = UserDefaultsManager.shared.getUserCredentials().secretKey else { return }
        let parameters = ["grant_type": "client_credentials", "client_id": apiKey, "client_secret": secretKey]
        AF.request(authorize, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let data = response.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
                as? [String: Any])?["access_token"] as? String {
                UserDefaultsManager.shared.setToken(token: token)
                print("\nRefresh token completed successfully. New token is: \(token)\n")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
