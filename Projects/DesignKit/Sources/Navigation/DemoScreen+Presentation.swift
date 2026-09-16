//
//  DemoScreen+Presentation.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import UIKit

public extension DemoScreen {
    static let labScreens: [DemoScreen] = [.labSurface, .labMorph, .labButtons, .labConcentric, .labAntiPattern]

    var title: String {
        switch self {
        case .portfolio:
            "Portfolio"
        case .market:
            "Market"
        case .trade:
            "Trade"
        case .search:
            "Search"
        case .labSurface:
            "Surface"
        case .labMorph:
            "Morph"
        case .labButtons:
            "Buttons"
        case .labConcentric:
            "Concentric"
        case .labAntiPattern:
            "Anti-patterns"
        }
    }

    var headline: String {
        "Demo \(title)"
    }

    var symbolName: String {
        switch self {
        case .portfolio:
            "chart.pie"
        case .market:
            "chart.line.uptrend.xyaxis"
        case .trade:
            "arrow.left.arrow.right"
        case .search:
            "magnifyingglass"
        case .labSurface:
            "square.on.square.intersection.dashed"
        case .labMorph:
            "circle.hexagongrid"
        case .labButtons:
            "button.horizontal"
        case .labConcentric:
            "rectangle.inset.filled"
        case .labAntiPattern:
            "exclamationmark.triangle"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .portfolio:
            .systemIndigo
        case .market:
            .systemTeal
        case .trade:
            .systemOrange
        case .search:
            .systemPink
        case .labSurface:
            .systemBlue
        case .labMorph:
            .systemMint
        case .labButtons:
            .systemGreen
        case .labConcentric:
            .systemPurple
        case .labAntiPattern:
            .systemBrown
        }
    }
}
