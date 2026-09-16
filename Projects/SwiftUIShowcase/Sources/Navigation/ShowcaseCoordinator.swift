//
//  ShowcaseCoordinator.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import Observation

@Observable
final class ShowcaseCoordinator {
    var selectedTab: ShowcaseTab
    var labPath: [DemoScreen]

    @ObservationIgnored let switchShowcase: @MainActor (ShowcaseKind) -> Void

    /// Derives the initial tab and lab stack from the launch screen.
    ///
    /// - Parameters:
    ///   - initialScreen: Screen requested at launch, if any.
    ///   - switchShowcase: Callback that asks the host to show another showcase.
    init(initialScreen: DemoScreen?, switchShowcase: @escaping @MainActor (ShowcaseKind) -> Void) {
        self.selectedTab = initialScreen.map(ShowcaseTab.init(screen:)) ?? .portfolio
        self.labPath = initialScreen.flatMap { $0.isLab ? [$0] : nil } ?? []
        self.switchShowcase = switchShowcase
    }
}
