//
//  GlassMorphLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import SwiftUI

struct GlassMorphLabView: View {
    @State private var isExpanded = false
    @State private var spacing = 40.0
    @Namespace private var namespace

    private let actions = ["bell", "star", "bookmark", "square.and.arrow.up"]
    private let segments = ["1H", "1D", "1W", "1M"]

    var body: some View {
        LabBackdrop(screen: .labMorph) {
            VStack(spacing: GlassTokens.containerSpacing) {
                Spacer()
                if #available(iOS 26, *) {
                    morphingControls
                } else {
                    legacyControls
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Container spacing: \(Int(spacing))")
                        .font(.footnote.monospacedDigit())
                    Slider(value: $spacing, in: 0...80, step: 4)
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: GlassTokens.cornerRadius))
                .padding()
            }
        }
    }

    @available(iOS 26, *)
    private var morphingControls: some View {
        GlassEffectContainer(spacing: spacing) {
            VStack(spacing: GlassTokens.containerSpacing) {
                HStack(spacing: GlassTokens.spacing) {
                    if isExpanded {
                        ForEach(actions, id: \.self) { action in
                            actionIcon(action)
                                .glassEffect()
                                .glassEffectID(action, in: namespace)
                        }
                    }
                    Button {
                        withAnimation(.bouncy) {
                            isExpanded.toggle()
                        }
                    } label: {
                        actionIcon(isExpanded ? "xmark" : "plus")
                    }
                    .buttonStyle(.glass)
                    .glassEffectID("toggle", in: namespace)
                }
                HStack(spacing: GlassTokens.spacing) {
                    ForEach(segments, id: \.self) { segment in
                        Text(segment)
                            .font(.headline)
                            .padding(.horizontal, GlassTokens.spacing)
                            .padding(.vertical, 8)
                            .glassEffect()
                            .glassEffectUnion(id: "segments", namespace: namespace)
                    }
                }
            }
        }
    }

    private var legacyControls: some View {
        VStack(spacing: GlassTokens.containerSpacing) {
            HStack(spacing: GlassTokens.spacing) {
                if isExpanded {
                    ForEach(actions, id: \.self) { action in
                        actionIcon(action)
                            .surfaceGlass(in: Circle())
                    }
                }
                Button {
                    withAnimation(.bouncy) {
                        isExpanded.toggle()
                    }
                } label: {
                    actionIcon(isExpanded ? "xmark" : "plus")
                }
                .adaptiveGlassButtonStyle()
            }
            LegacyGlassNote()
        }
    }

    /// Builds the fixed size symbol used by every morphing chip.
    ///
    /// - Parameter name: SF Symbol name.
    /// - Returns: The symbol sized for a chip.
    private func actionIcon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.title3)
            .frame(width: 48, height: 48)
            .accessibilityLabel(name.replacingOccurrences(of: ".", with: " "))
    }
}
