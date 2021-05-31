//
//  ListViewController.swift
//  AFRetryRequest
//
//  Created by a.alami on 12/10/2020.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class ListViewController: UIViewController {
    lazy var viewModel: ListViewModel = {
        return ListViewModel()
    }()
    
    @IBOutlet weak var responseTexView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wsGetData()
    }
    
    func wsGetData() {
        viewModel.getData { (result) in
            switch result {
            case .success(let data):
                //print("\n")
                //print(String(data: data, encoding: .utf8) ?? "-")
                let token = UserDefaultsManager.shared.getToken() ?? "-"
                let refreshToken = UserDefaultsManager.shared.getRefreshToken() ?? "-"
                let dato = String(data: data, encoding: .utf8) ?? "-"
                self.responseTexView.text = "Token: \(token) \n\n refresh: \(refreshToken) \n\n response: \(dato)"
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func rechargeAction(_ sender: Any) {
        wsGetData()
    }
    
}
