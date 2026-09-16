//
//  DemoTabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

enum DemoTabBuilder {

    /// Assembles the demo tab scene for a screen.
    ///
    /// - Parameters:
    ///   - screen: Screen that provides the title, headline and color.
    ///   - environment: Environment carrying the showcase switch callback.
    /// - Returns: The view controller of the scene.
    static func build(screen: DemoScreen, environment: ShowcaseEnvironment) -> UIViewController {
        let viewModel = DemoTabViewModel(screen: screen)

        return DemoTabViewController(viewModel: viewModel, environment: environment)
    }
}
