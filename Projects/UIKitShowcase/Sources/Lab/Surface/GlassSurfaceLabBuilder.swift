//
//  GlassSurfaceLabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

enum GlassSurfaceLabBuilder {

    /// Assembles the glass surface lab scene.
    ///
    /// - Returns: The view controller of the scene.
    static func build() -> UIViewController {
        GlassSurfaceLabViewController(viewModel: GlassSurfaceLabViewModel())
    }
}
