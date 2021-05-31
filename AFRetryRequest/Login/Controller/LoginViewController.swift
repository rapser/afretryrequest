//
//  ViewController.swift
//  AFRetryRequest
//
//  Created by alireza.a on 11/10/2020.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
import Alamofire
import Combine
class LoginViewController: UIViewController {
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    @IBOutlet weak var apiKeyTF: UITextField!
    @IBOutlet weak var secretKeyTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        apiKeyTF.text = "06686674"
        secretKeyTF.text = "111111"
        
        if let _ = UserDefaultsManager.shared.getToken() {
            performSegue(withIdentifier: "toListView", sender: self)
        }
    }
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        
        guard let apiKey = apiKeyTF.text, let secretKey = secretKeyTF.text else { return }
        viewModel.login(apiKey: apiKey, secretKey: secretKey)
    }
}

