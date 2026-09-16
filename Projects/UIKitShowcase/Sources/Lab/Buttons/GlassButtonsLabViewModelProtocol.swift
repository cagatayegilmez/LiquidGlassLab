//
//  GlassButtonsLabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

struct GlassButtonRow {
    let title: String
    let cornerStyle: UIButton.Configuration.CornerStyle
    let isIconOnly: Bool
}

struct GlassButtonSample {
    let title: String
    let symbolName: String
    let isProminent: Bool
    let tint: GlassTokens.Tint?
}

protocol GlassButtonsLabViewModelProtocol: AnyObject {
    var title: String { get }
    var backgroundColor: UIColor { get }
    var rows: [GlassButtonRow] { get }
    var samples: [GlassButtonSample] { get }
}
