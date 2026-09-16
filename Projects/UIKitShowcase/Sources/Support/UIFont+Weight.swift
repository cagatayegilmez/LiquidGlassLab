//
//  UIFont+Weight.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

extension UIFont {

    /// Returns the same font with a different weight.
    ///
    /// - Parameter weight: Weight to apply.
    /// - Returns: The adjusted font.
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
}
