//
//  UIFont+MonospacedDigit.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

public extension UIFont {

    /// Builds a monospaced digit font sized like the given text style.
    ///
    /// - Parameters:
    ///   - style: Text style that provides the point size.
    ///   - weight: Font weight.
    /// - Returns: The font.
    static func monospacedDigit(_ style: UIFont.TextStyle,
                                weight: UIFont.Weight = .regular) -> UIFont {
        .monospacedDigitSystemFont(ofSize: UIFont.preferredFont(forTextStyle: style).pointSize,
                                   weight: weight)
    }
}
