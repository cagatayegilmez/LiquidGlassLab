//
//  ShowcaseSwitchToolbarItem.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import SwiftUI

struct ShowcaseSwitchToolbarItem: ToolbarContent {
    @Environment(ShowcaseCoordinator.self)
    private var coordinator

    private let current = ShowcaseKind.swiftui

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(current.title) {
                coordinator.switchShowcase(current.counterpart)
            }
            .accessibilityLabel("Switch to the \(current.counterpart.title) showcase")
        }
    }
}
