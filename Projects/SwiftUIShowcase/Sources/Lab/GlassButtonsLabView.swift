//
//  GlassButtonsLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import SwiftUI

struct GlassButtonsLabView: View {
    var body: some View {
        LabBackdrop(screen: .labButtons) {
            ScrollView {
                VStack(spacing: GlassTokens.containerSpacing) {
                    ForEach(BorderShapeChoice.allCases, id: \.self) { choice in
                        buttonRow(for: choice)
                    }
                    if #unavailable(iOS 26) {
                        LegacyGlassNote()
                    }
                }
                .padding()
            }
        }
    }

    /// Builds one row that pairs both glass styles with a single border shape.
    ///
    /// - Parameter choice: Border shape shared by the row.
    /// - Returns: The row view.
    private func buttonRow(for choice: BorderShapeChoice) -> some View {
        VStack(alignment: .leading, spacing: GlassTokens.spacing) {
            Text(choice.title)
                .font(.headline)
            if choice == .circle {
                buttons
                    .labelStyle(.iconOnly)
            } else {
                buttons
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .buttonBorderShape(choice.shape)
    }

    private var buttons: some View {
        HStack(spacing: GlassTokens.spacing) {
            Button("Glass", systemImage: "drop") {}
                .adaptiveGlassButtonStyle()
            Button("Prominent", systemImage: "drop.fill") {}
                .adaptiveProminentGlassButtonStyle()
            Button("Tinted", systemImage: "paintpalette") {}
                .adaptiveProminentGlassButtonStyle()
                .tint(GlassTokens.Tint.primaryAction.color)
        }
    }
}

enum BorderShapeChoice: CaseIterable {
    case capsule
    case roundedRectangle
    case circle

    var title: String {
        switch self {
        case .capsule:
            "Capsule"
        case .roundedRectangle:
            "Rounded rectangle"
        case .circle:
            "Circle"
        }
    }

    var shape: ButtonBorderShape {
        switch self {
        case .capsule:
            .capsule
        case .roundedRectangle:
            .roundedRectangle
        case .circle:
            .circle
        }
    }
}
