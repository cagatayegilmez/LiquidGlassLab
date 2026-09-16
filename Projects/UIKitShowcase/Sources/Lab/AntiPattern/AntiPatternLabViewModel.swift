//
//  AntiPatternLabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

final class AntiPatternLabViewModel: AntiPatternLabViewModelProtocol {
    let title = DemoScreen.labAntiPattern.title
    let backgroundColor = DemoScreen.labAntiPattern.backgroundColor
    let paragraph = """
    Body text like this is content. Glass belongs to controls that float above \
    it, not to the content itself.
    """
    let chips = ["Alerts", "Watchlist", "Orders"]
    let cases = AntiPatternCase.allCases
}
