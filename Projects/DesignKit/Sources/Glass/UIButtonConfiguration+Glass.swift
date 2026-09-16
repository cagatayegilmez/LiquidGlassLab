//
//  UIButtonConfiguration+Glass.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

public extension UIButton.Configuration {

    /// Builds a secondary glass button, using the tinted style below iOS 26.
    ///
    /// - Returns: Configuration for a secondary action.
    static func adaptiveGlass() -> UIButton.Configuration {
        if #available(iOS 26, *) {
            .glass()
        } else {
            .tinted()
        }
    }

    /// Builds a prominent glass button, using the filled style below iOS 26.
    ///
    /// - Returns: Configuration for a primary action.
    static func adaptiveProminentGlass() -> UIButton.Configuration {
        if #available(iOS 26, *) {
            .prominentGlass()
        } else {
            .filled()
        }
    }
}
