//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let vc = MainViewController()
        let mainVCConfigurator: MainConfiguratorProtocol = MainConfigurator()
        mainVCConfigurator.configure(with: vc)
        let navController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

