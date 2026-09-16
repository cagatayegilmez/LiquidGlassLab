//
//  SceneDelegate.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        let options = LaunchOptions(arguments: CommandLine.arguments)
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = ShowcaseContainerViewController(launchOptions: options)
        window.makeKeyAndVisible()
        self.window = window
    }
}
