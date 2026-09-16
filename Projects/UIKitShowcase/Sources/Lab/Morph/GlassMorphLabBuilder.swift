//
//  GlassMorphLabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

enum GlassMorphLabBuilder {

    /// Assembles the glass morph lab scene.
    ///
    /// - Returns: The view controller of the scene.
    static func build() -> UIViewController {
        GlassMorphLabViewController(viewModel: GlassMorphLabViewModel())
    }
}
