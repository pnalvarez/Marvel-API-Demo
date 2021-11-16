//
//  SceneDelegate.swift
//  Marvel-API-Demo
//
//  Created by Pedro Alvarez on 13/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.makeKeyAndVisible()
            self.window = window
            let characterListViewController = GeneralCharacterListFactory.make(pageSize: Constants.pageSize)
            window.rootViewController = UINavigationController(rootViewController: characterListViewController) 
        }
    }
}
