//
//  AppCordinator.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 20/10/2020.
//

import UIKit

class AppCordinator {
    private let window : UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = BreedListViewController.instantiate(viewModel: BreedListViewModel())
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
