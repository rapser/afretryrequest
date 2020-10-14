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
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData { (result) in
            switch result {
            case .success(let data):
                print("\n")
                print(String(data: data, encoding: .utf8))
            case .failure(let error):
                print(error)
            }
        }
    }
}
