//
//  GlassSurfaceLabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import Observation
import UIKit

@Observable
final class GlassSurfaceLabViewModel: GlassSurfaceLabViewModelProtocol {
    let title = DemoScreen.labSurface.title
    let backgroundColor = DemoScreen.labSurface.backgroundColor
    private(set) var variant = GlassVariant.regular
    private(set) var tint = TintChoice.none
    private(set) var isInteractive = false
    private(set) var shape = SurfaceShape.capsule

    func select(_ variant: GlassVariant) {
        self.variant = variant
    }

    func select(_ tint: TintChoice) {
        self.tint = tint
    }

    func select(_ shape: SurfaceShape) {
        self.shape = shape
    }

    func setInteractive(_ isInteractive: Bool) {
        self.isInteractive = isInteractive
    }
}
