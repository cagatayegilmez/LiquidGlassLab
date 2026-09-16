//
//  ShowcaseKind.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

nonisolated public enum ShowcaseKind: String, CaseIterable, Sendable {

    case uikit
    case swiftui

    public var title: String {
        switch self {
        case .uikit:
            "UIKit"
        case .swiftui:
            "SwiftUI"
        }
    }

    public var counterpart: ShowcaseKind {
        switch self {
        case .uikit:
            .swiftui
        case .swiftui:
            .uikit
        }
    }
}
