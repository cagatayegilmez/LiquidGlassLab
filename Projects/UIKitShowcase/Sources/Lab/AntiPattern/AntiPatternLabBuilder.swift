//
//  AntiPatternLabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

enum AntiPatternLabBuilder {

    /// Assembles the anti-pattern lab scene.
    ///
    /// - Returns: The view controller of the scene.
    static func build() -> UIViewController {
        AntiPatternLabViewController(viewModel: AntiPatternLabViewModel())
    }
}
