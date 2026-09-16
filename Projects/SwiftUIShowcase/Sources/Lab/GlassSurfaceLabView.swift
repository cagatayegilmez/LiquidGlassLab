//
//  GlassSurfaceLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import SwiftUI

struct GlassSurfaceLabView: View {
    @State private var variant = GlassVariant.regular
    @State private var tint = TintChoice.none
    @State private var isInteractive = false
    @State private var shape = SurfaceShapeChoice.capsule

    var body: some View {
        VStack(spacing: 0) {
            LabBackdrop(screen: .labSurface) {
                preview
            }
            Form {
                Picker("Variant", selection: $variant) {
                    ForEach(GlassVariant.allCases, id: \.self) { Text($0.title) }
                }
                .pickerStyle(.segmented)
                Picker("Tint", selection: $tint) {
                    ForEach(TintChoice.allCases, id: \.self) { Text($0.title) }
                }
                Toggle("Interactive", isOn: $isInteractive)
                Picker("Shape", selection: $shape) {
                    ForEach(SurfaceShapeChoice.allCases, id: \.self) { Text($0.title) }
                }
                .pickerStyle(.segmented)
            }
            .frame(height: 260)
        }
    }

    @ViewBuilder private var preview: some View {
        if #available(iOS 26, *) {
            previewLabel
                .glassEffect(configuredGlass, in: shape.shape)
        } else {
            VStack {
                previewLabel
                    .surfaceGlass(in: shape.shape, tint: tint.tint, interactive: isInteractive)
                LegacyGlassNote()
            }
        }
    }

    @available(iOS 26, *)
    private var configuredGlass: Glass {
        Glass.regular.tint(tint.tint?.color).interactive(isInteractive).variant(variant)
    }

    private var previewLabel: some View {
        Label("Liquid Glass", systemImage: "drop.fill")
            .font(.title2.bold())
            .padding(GlassTokens.containerSpacing)
    }
}

enum GlassVariant: CaseIterable {
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

enum TintChoice: CaseIterable {
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

enum SurfaceShapeChoice: CaseIterable {
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

    var shape: AnyShape {
        switch self {
        case .capsule:
            AnyShape(Capsule())
        case .roundedRectangle:
            AnyShape(RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
        case .circle:
            AnyShape(Circle())
        }
    }
}

@available(iOS 26, *)
private extension Glass {
    /// Rebuilds the glass with the picked variant while keeping tint and interactivity.
    ///
    /// - Parameter variant: Variant chosen in the lab controls.
    /// - Returns: Glass of that variant carrying the same tint and interactive flag.
    func variant(_ variant: GlassVariant) -> Glass {
        switch variant {
        case .regular:
            self
        case .clear:
            self == .regular ? .clear : self
        case .identity:
            .identity
        }
    }
}
