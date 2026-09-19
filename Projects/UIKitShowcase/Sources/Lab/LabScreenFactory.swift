//
//  LabScreenFactory.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

enum LabScreenFactory {
    /// Assembles the scene of a lab screen and applies the bar behavior shared by every lab screen.
    ///
    /// - Parameter screen: Lab screen to open.
    /// - Returns: The view controller, or nil when the screen is not part of the lab.
    static func makeViewController(for screen: DemoScreen) -> UIViewController? {
        guard let controller = makeScene(for: screen) else {
            return nil
        }
        if #available(iOS 27.1, *) {
            controller.navigationItem.verticalBarCompressionBehavior = .prefersBarItems
        }
        return controller
    }

    /// Picks the builder of a lab screen.
    ///
    /// - Parameter screen: Lab screen to open.
    /// - Returns: The view controller, or nil when the screen is not part of the lab.
    private static func makeScene(for screen: DemoScreen) -> UIViewController? {
        switch screen {
        case .labSurface:
            GlassSurfaceLabBuilder.build()
        case .labMorph:
            GlassMorphLabBuilder.build()
        case .labButtons:
            GlassButtonsLabBuilder.build()
        case .labConcentric:
            ConcentricLabBuilder.build()
        case .labAntiPattern:
            AntiPatternLabBuilder.build()
        case .portfolio, .market, .trade, .search:
            nil
        }
    }
}
