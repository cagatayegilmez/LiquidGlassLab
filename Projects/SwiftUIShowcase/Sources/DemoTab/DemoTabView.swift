//
//  DemoTabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import SwiftUI

struct DemoTabView: View {
    let screen: DemoScreen

    @State private var query = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text(screen.headline)
                        .font(.largeTitle.bold())
                        .containerRelativeFrame(.vertical) { height, _ in
                            height * GlassTokens.headlineHeightFraction
                        }
                    ForEach(releases) { release in
                        ReleaseRow(release: release)
                    }
                }
                .padding(.horizontal)
            }
            .foregroundStyle(.white)
            .background(Color(uiColor: screen.backgroundColor))
            .modifier(ReleaseSearchModifier(isEnabled: screen == .search, query: $query))
            .modifier(LegacyTabBarBackgroundModifier())
            .navigationTitle(screen.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ShowcaseSwitchToolbarItem()
            }
        }
    }

    private var releases: [IOSRelease] {
        IOSReleaseCatalog.releases(matching: query)
    }
}

private struct ReleaseRow: View {
    let release: IOSRelease

    var body: some View {
        HStack {
            Text(release.name)
                .font(.headline)
            Spacer()
            Text(String(release.year))
                .font(.subheadline.monospacedDigit())
        }
        .padding(.vertical, GlassTokens.spacing)
        .overlay(alignment: .bottom) {
            Divider()
                .overlay(.white.opacity(0.4))
        }
    }
}

private struct ReleaseSearchModifier: ViewModifier {
    let isEnabled: Bool
    @Binding var query: String

    func body(content: Content) -> some View {
        if isEnabled {
            content.searchable(text: $query, prompt: "Version")
        } else {
            content
        }
    }
}
