//
//  AntiPatternLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import SwiftUI

struct AntiPatternLabView: View {
    private let paragraph = """
    Body text like this is content. Glass belongs to controls that float above \
    it, not to the content itself.
    """

    var body: some View {
        LabBackdrop(screen: .labAntiPattern) {
            ScrollView {
                VStack(spacing: GlassTokens.containerSpacing) {
                    AntiPatternCard(
                        title: "Glass on content",
                        why: AntiPatternCopy.glassOnContent
                    ) {
                        Text(paragraph)
                            .padding()
                            .modifier(RawGlassModifier())
                    } fixed: {
                        Text(paragraph)
                            .padding()
                            .background(.background, in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
                    }
                    AntiPatternCard(
                        title: "Glass on glass",
                        why: AntiPatternCopy.glassOnGlass
                    ) {
                        chipRow
                            .padding()
                            .modifier(RawGlassModifier())
                    } fixed: {
                        chipRow
                    }
                    AntiPatternCard(
                        title: "glassEffect on a Button",
                        why: AntiPatternCopy.glassOnButton
                    ) {
                        Button("Confirm") {}
                            .padding()
                            .modifier(RawGlassModifier())
                    } fixed: {
                        Button("Confirm") {}
                            .adaptiveProminentGlassButtonStyle()
                    }
                    if #unavailable(iOS 26) {
                        LegacyGlassNote()
                    }
                }
                .padding()
            }
        }
    }

    private var chipRow: some View {
        HStack(spacing: GlassTokens.spacing) {
            ForEach(["Alerts", "Watchlist", "Orders"], id: \.self) { chip in
                Text(chip)
                    .padding(.horizontal, GlassTokens.spacing)
                    .padding(.vertical, 8)
                    .modifier(RawGlassModifier())
            }
        }
    }
}

private struct AntiPatternCard<Wrong: View, Fixed: View>: View {
    let title: String
    let why: String
    @ViewBuilder let wrong: Wrong
    @ViewBuilder let fixed: Fixed

    var body: some View {
        VStack(alignment: .leading, spacing: GlassTokens.spacing) {
            Text(title)
                .font(.headline)
            Label("Wrong", systemImage: "xmark.circle")
                .font(.caption)
                .foregroundStyle(GlassTokens.Tint.negative.color)
            wrong
            Label("Better", systemImage: "checkmark.circle")
                .font(.caption)
                .foregroundStyle(GlassTokens.Tint.positive.color)
            fixed
            Text(why)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
    }
}

private struct RawGlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.glassEffect(.regular, in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
        } else {
            content.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
        }
    }
}

private enum AntiPatternCopy {
    static let glassOnContent = """
    Text turns into a floating control and competes with the real ones. Content \
    stays on its own layer.
    """
    static let glassOnGlass = """
    Stacked glass doubles refraction and blur, so the inner element loses \
    legibility. One surface per group.
    """
    static let glassOnButton = """
    The modifier draws a static surface. Only the glass button style gives press \
    feedback and morphing.
    """
}
