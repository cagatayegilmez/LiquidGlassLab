//
//  View+SurfaceGlass.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import SwiftUI

public extension View {

    /// Puts the view on a glass surface, falling back to a material below iOS 26.
    ///
    /// - Parameters:
    ///   - shape: Shape that bounds the surface.
    ///   - tint: Semantic tint mixed into the surface.
    ///   - interactive: Whether the surface reacts to touches.
    /// - Returns: The view with a glass or material background.
    func surfaceGlass<S: Shape>(in shape: S, tint: GlassTokens.Tint? = nil, interactive: Bool = false) -> some View {
        modifier(SurfaceGlassModifier(shape: shape, tint: tint, interactive: interactive))
    }

    /// Puts the view on a rounded rectangle glass surface using the shared corner radius.
    ///
    /// - Parameters:
    ///   - tint: Semantic tint mixed into the surface.
    ///   - interactive: Whether the surface reacts to touches.
    /// - Returns: The view with a glass or material background.
    func surfaceGlass(tint: GlassTokens.Tint? = nil, interactive: Bool = false) -> some View {
        surfaceGlass(in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius), tint: tint, interactive: interactive)
    }
}

struct SurfaceGlassModifier<S: Shape>: ViewModifier {
    let shape: S
    let tint: GlassTokens.Tint?
    let interactive: Bool

    @Environment(\.accessibilityReduceTransparency)
    private var reduceTransparency

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.glassEffect(Glass.regular.tint(tint?.color).interactive(interactive), in: shape)
        } else if reduceTransparency {
            content.background(Color(uiColor: .secondarySystemBackground), in: shape)
        } else {
            content.background(.ultraThinMaterial, in: shape)
        }
    }
}
