//
//  ConcentricLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import SwiftUI

struct ConcentricLabView: View {
    @State private var containerRadius = 32.0

    private let inset = 16.0

    var body: some View {
        LabBackdrop(screen: .labConcentric) {
            VStack(spacing: GlassTokens.containerSpacing) {
                Spacer()
                HStack(spacing: GlassTokens.containerSpacing) {
                    card(title: "Concentric", shape: innerShape)
                    card(title: "Fixed 12pt", shape: AnyShape(RoundedRectangle(cornerRadius: 12)))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Container radius: \(Int(containerRadius))")
                        .font(.footnote.monospacedDigit())
                    Slider(value: $containerRadius, in: 0...64, step: 2)
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
            }
            .padding()
        }
    }

    private var innerShape: AnyShape {
        if #available(iOS 26, *) {
            AnyShape(ConcentricRectangle())
        } else {
            AnyShape(RoundedRectangle(cornerRadius: max(containerRadius - inset, 0)))
        }
    }

    /// Builds a white container with an inner tinted card cut by the given shape.
    ///
    /// - Parameters:
    ///   - title: Caption under the card.
    ///   - shape: Shape used for the inner card.
    /// - Returns: The card view.
    private func card(title: String, shape: AnyShape) -> some View {
        VStack(spacing: GlassTokens.spacing) {
            shape
                .fill(GlassTokens.Tint.primaryAction.color)
                .frame(height: 120)
                .padding(inset)
                .background(.white, in: RoundedRectangle(cornerRadius: containerRadius))
                .modifier(ContainerShapeModifier(radius: containerRadius))
            Text(title)
                .font(.caption)
        }
    }
}

private struct ContainerShapeModifier: ViewModifier {
    let radius: Double

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.containerShape(.rect(cornerRadius: radius))
        } else {
            content
        }
    }
}
