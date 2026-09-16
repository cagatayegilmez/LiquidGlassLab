//
//  GlassButtonsLabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit

final class GlassButtonsLabViewModel: GlassButtonsLabViewModelProtocol {
    let title = DemoScreen.labButtons.title
    let backgroundColor = DemoScreen.labButtons.backgroundColor
    let rows = [
        GlassButtonRow(title: "Capsule", cornerStyle: .capsule, isIconOnly: false),
        GlassButtonRow(title: "Rounded rectangle", cornerStyle: .fixed, isIconOnly: false),
        GlassButtonRow(title: "Circle", cornerStyle: .capsule, isIconOnly: true)
    ]
    let samples = [
        GlassButtonSample(title: "Glass", symbolName: "drop", isProminent: false, tint: nil),
        GlassButtonSample(title: "Prominent", symbolName: "drop.fill", isProminent: true, tint: nil),
        GlassButtonSample(title: "Tinted", symbolName: "paintpalette", isProminent: true, tint: .primaryAction)
    ]
}
