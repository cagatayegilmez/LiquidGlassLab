//
//  LabScreenFactory.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

enum LabScreenFactory {
    /// Assembles the scene of a lab screen.
    ///
    /// - Parameter screen: Lab screen to open.
    /// - Returns: The view controller, or nil when the screen is not part of the lab.
    static func makeViewController(for screen: DemoScreen) -> UIViewController? {
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
