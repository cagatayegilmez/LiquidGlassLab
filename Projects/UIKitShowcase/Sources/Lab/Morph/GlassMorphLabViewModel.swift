//
//  GlassMorphLabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import Observation
import UIKit

@Observable
final class GlassMorphLabViewModel: GlassMorphLabViewModelProtocol {
    let title = DemoScreen.labMorph.title
    let backgroundColor = DemoScreen.labMorph.backgroundColor
    let actionSymbols = ["bell", "star", "bookmark", "square.and.arrow.up"]
    let segments = ["1H", "1D", "1W", "1M"]
    private(set) var isExpanded = false
    private(set) var spacing: CGFloat = 40

    var toggleSymbolName: String {
        isExpanded ? "xmark" : "plus"
    }

    var spacingText: String {
        "Container spacing: \(Int(spacing))"
    }

    func toggleExpanded() {
        isExpanded.toggle()
    }

    func updateSpacing(_ spacing: CGFloat) {
        self.spacing = spacing.rounded()
    }
}
