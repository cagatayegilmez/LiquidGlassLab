//
//  UIKitShowcase.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

public enum UIKitShowcase {
    
    /// Builds the UIKit showcase rooted in a tab bar controller.
    ///
    /// - Parameter environment: Initial screen and the showcase switch callback provided by the host.
    /// - Returns: View controller that hosts the showcase.
    public static func makeRootViewController(environment: ShowcaseEnvironment) -> UIViewController {
        ShowcaseTabBarController(environment: environment)
    }
}
