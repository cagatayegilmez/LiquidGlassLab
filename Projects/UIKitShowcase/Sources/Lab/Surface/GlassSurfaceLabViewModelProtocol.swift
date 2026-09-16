//
//  GlassSurfaceLabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

enum GlassVariant: Int, CaseIterable {
    case regular
    case clear
    case identity

    var title: String {
        switch self {
        case .regular:
            "Regular"
        case .clear:
            "Clear"
        case .identity:
            "Identity"
        }
    }
}

enum TintChoice: Int, CaseIterable {
    case none
    case primaryAction
    case positive
    case negative

    var title: String {
        switch self {
        case .none:
            "None"
        case .primaryAction:
            "Primary"
        case .positive:
            "Positive"
        case .negative:
            "Negative"
        }
    }

    var tint: GlassTokens.Tint? {
        switch self {
        case .none:
            nil
        case .primaryAction:
            .primaryAction
        case .positive:
            .positive
        case .negative:
            .negative
        }
    }
}

enum SurfaceShape: Int, CaseIterable {
    case capsule
    case roundedRectangle
    case circle

    var title: String {
        switch self {
        case .capsule:
            "Capsule"
        case .roundedRectangle:
            "Rectangle"
        case .circle:
            "Circle"
        }
    }
}

protocol GlassSurfaceLabViewModelProtocol: AnyObject {
    var title: String { get }
    var backgroundColor: UIColor { get }
    var variant: GlassVariant { get }
    var tint: TintChoice { get }
    var isInteractive: Bool { get }
    var shape: SurfaceShape { get }

    /// Picks the glass variant shown by the preview.
    ///
    /// - Parameter variant: Variant chosen in the controls.
    func select(_ variant: GlassVariant)

    /// Picks the tint mixed into the preview surface.
    ///
    /// - Parameter tint: Tint chosen in the controls.
    func select(_ tint: TintChoice)

    /// Picks the shape that bounds the preview surface.
    ///
    /// - Parameter shape: Shape chosen in the controls.
    func select(_ shape: SurfaceShape)

    /// Turns touch feedback of the preview surface on or off.
    ///
    /// - Parameter isInteractive: Whether the surface reacts to touches.
    func setInteractive(_ isInteractive: Bool)
}
