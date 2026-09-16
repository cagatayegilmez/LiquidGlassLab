//
//  GlassButtonsLabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import UIKit

enum GlassButtonsLabBuilder {

    /// Assembles the glass buttons lab scene.
    ///
    /// - Returns: The view controller of the scene.
    static func build() -> UIViewController {
        GlassButtonsLabViewController(viewModel: GlassButtonsLabViewModel())
    }
}
