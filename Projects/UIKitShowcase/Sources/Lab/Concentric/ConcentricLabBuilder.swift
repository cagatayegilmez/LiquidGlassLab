//
//  ConcentricLabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

enum ConcentricLabBuilder {

    /// Assembles the concentric corners lab scene.
    ///
    /// - Returns: The view controller of the scene.
    static func build() -> UIViewController {
        ConcentricLabViewController(viewModel: ConcentricLabViewModel())
    }
}
