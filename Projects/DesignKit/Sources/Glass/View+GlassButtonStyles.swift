//
//  View+GlassButtonStyles.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import SwiftUI

public extension View {

    /// Applies the glass button style, falling back to the bordered style below iOS 26.
    ///
    /// - Returns: The view with a secondary button style.
    func adaptiveGlassButtonStyle() -> some View {
        modifier(AdaptiveGlassButtonStyleModifier(isProminent: false))
    }

    /// Applies the prominent glass button style, falling back to bordered prominent below iOS 26.
    ///
    /// - Returns: The view with a primary button style.
    func adaptiveProminentGlassButtonStyle() -> some View {
        modifier(AdaptiveGlassButtonStyleModifier(isProminent: true))
    }
}

struct AdaptiveGlassButtonStyleModifier: ViewModifier {
    let isProminent: Bool

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            if isProminent {
                content.buttonStyle(.glassProminent)
            } else {
                content.buttonStyle(.glass)
            }
        } else {
            if isProminent {
                content.buttonStyle(.borderedProminent)
            } else {
                content.buttonStyle(.bordered)
            }
        }
    }
}
