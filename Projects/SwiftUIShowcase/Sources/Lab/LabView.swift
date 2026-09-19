//
//  LabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import SwiftUI

struct LabView: View {
    @Environment(ShowcaseCoordinator.self)
    private var coordinator

    var body: some View {
        @Bindable var coordinator = coordinator

        NavigationStack(path: $coordinator.labPath) {
            List(DemoScreen.labScreens, id: \.self) { screen in
                NavigationLink(value: screen) {
                    Label(screen.title, systemImage: screen.symbolName)
                }
            }
            .modifier(LegacyTabBarBackgroundModifier())
            .navigationTitle("Lab")
            .navigationDestination(for: DemoScreen.self) { screen in
                LabDestination(screen: screen)
            }
            .toolbar {
                ShowcaseSwitchToolbarItem()
            }
        }
        .modifier(VerticalBarBehaviorModifier(isDisabled: coordinator.labPath.last?.prefersHorizontalBars ?? false))
    }
}

private struct VerticalBarBehaviorModifier: ViewModifier {
    let isDisabled: Bool

    func body(content: Content) -> some View {
        if #available(iOS 27.1, *) {
            content.toolbarVerticalBehavior(isDisabled ? .disabled : .automatic)
        } else {
            content
        }
    }
}

private struct LabDestination: View {
    let screen: DemoScreen

    var body: some View {
        Group {
            switch screen {
            case .labSurface:
                GlassSurfaceLabView()
            case .labMorph:
                GlassMorphLabView()
            case .labButtons:
                GlassButtonsLabView()
            case .labConcentric:
                ConcentricLabView()
            case .labAntiPattern:
                AntiPatternLabView()
            default:
                ContentUnavailableView("Not part of this showcase", systemImage: "questionmark.square.dashed")
            }
        }
        .navigationTitle(screen.title)
        .navigationBarTitleDisplayMode(.inline)
        .modifier(VerticalBarCompressionModifier())
    }
}

private struct VerticalBarCompressionModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 27.1, *) {
            content.toolbarVerticalCompressionBehavior(.prefersToolbarItems)
        } else {
            content
        }
    }
}
