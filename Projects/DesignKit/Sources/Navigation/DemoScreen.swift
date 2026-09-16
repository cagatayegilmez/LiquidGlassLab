//
//  DemoScreen.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

nonisolated public enum DemoScreen: String, CaseIterable, Sendable {
    case portfolio
    case market
    case trade
    case search
    case labSurface = "lab.surface"
    case labMorph = "lab.morph"
    case labButtons = "lab.buttons"
    case labConcentric = "lab.concentric"
    case labAntiPattern = "lab.antipattern"

    public var isLab: Bool {
        rawValue.hasPrefix("lab.")
    }
}
