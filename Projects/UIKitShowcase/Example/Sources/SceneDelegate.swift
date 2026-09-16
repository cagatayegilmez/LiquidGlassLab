//
//  SceneDelegate.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit
import UIKitShowcase

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
        let environment = ShowcaseEnvironment(initialScreen: options.initialScreen) { _ in }
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = UIKitShowcase.makeRootViewController(environment: environment)
        window.makeKeyAndVisible()
        self.window = window
    }
}
