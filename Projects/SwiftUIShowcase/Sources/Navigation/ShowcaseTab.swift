//
//  ShowcaseTab.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit

enum ShowcaseTab: Hashable {
    case portfolio
    case market
    case lab
    case trade
    case search

    /// Maps a demo screen to the tab that presents it.
    ///
    /// - Parameter screen: Screen requested at launch.
    init(screen: DemoScreen) {
        switch screen {
        case .portfolio:
            self = .portfolio
        case .market:
            self = .market
        case .trade:
            self = .trade
        case .search:
            self = .search
        case .labSurface, .labMorph, .labButtons, .labConcentric, .labAntiPattern:
            self = .lab
        }
    }
}
