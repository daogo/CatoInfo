//
//  SceneDelegate.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 20/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCordinator : AppCordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        appCordinator = AppCordinator(window: window)
        appCordinator?.start()
    }


}

