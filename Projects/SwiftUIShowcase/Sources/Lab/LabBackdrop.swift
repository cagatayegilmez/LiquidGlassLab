//
//  LabBackdrop.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import SwiftUI

struct LabBackdrop<Content: View>: View {
    let screen: DemoScreen
    @ViewBuilder let content: Content

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(uiColor: screen.backgroundColor)
                    .ignoresSafeArea()
            }
    }
}

struct LegacyGlassNote: View {
    var body: some View {
        Text("Liquid Glass needs iOS 26. This device shows the material fallback.")
            .font(.footnote)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding()
    }
}
