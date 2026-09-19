//
//  GlassTokens.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import SwiftUI
import UIKit

nonisolated public enum GlassTokens {
    public static let cornerRadius: CGFloat = 20
    public static let spacing: CGFloat = 12
    public static let containerSpacing: CGFloat = 24
    public static let headlineHeightFraction: CGFloat = 0.5
    public static let legacyBarBackground = UIColor(red: 0.96, green: 0.95, blue: 0.92, alpha: 1)

    public enum Tint: CaseIterable, Sendable {
        case primaryAction
        case positive
        case negative

        public var uiColor: UIColor {
            switch self {
            case .primaryAction:
                .systemIndigo
            case .positive:
                .systemGreen
            case .negative:
                .systemRed
            }
        }

        public var color: Color {
            Color(uiColor: uiColor)
        }
    }
}
