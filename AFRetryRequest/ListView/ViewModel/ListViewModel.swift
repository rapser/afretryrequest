//
//  ListViewModel.swift
//  AFRetryRequest
//
//  Created by a.alami on 12/10/2020.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import Foundation
class ListViewModel {
    func getData(_ completion: @escaping (Result<Data, CustomError>) -> Void) {
        let url = "https://pagosdigitales-dev.azurewebsites.net/v2/users/user"
            //"https://api.petfinder.com/v2/animals"
        
        NetworkManager.shared.request(url) { (result) in
            completion(result)
        }
    }
}
