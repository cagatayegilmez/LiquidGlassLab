//
//  GlassMorphLabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import UIKit

protocol GlassMorphLabViewModelProtocol: AnyObject {
    var title: String { get }
    var backgroundColor: UIColor { get }
    var actionSymbols: [String] { get }
    var segments: [String] { get }
    var isExpanded: Bool { get }
    var toggleSymbolName: String { get }
    var spacing: CGFloat { get }
    var spacingText: String { get }

    /// Reveals or hides the action chips.
    func toggleExpanded()

    /// Stores the slider value that drives the glass container spacing.
    ///
    /// - Parameter spacing: Spacing in points.
    func updateSpacing(_ spacing: CGFloat)
}
