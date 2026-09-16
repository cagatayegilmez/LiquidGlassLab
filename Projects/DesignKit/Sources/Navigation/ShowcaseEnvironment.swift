//
//  ShowcaseEnvironment.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

public struct ShowcaseEnvironment {
    public let initialScreen: DemoScreen?
    public let onSwitchShowcase: @MainActor (ShowcaseKind) -> Void

    public init(initialScreen: DemoScreen?, onSwitchShowcase: @escaping @MainActor (ShowcaseKind) -> Void) {
        self.initialScreen = initialScreen
        self.onSwitchShowcase = onSwitchShowcase
    }
}
