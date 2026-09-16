//
//  AntiPatternLabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

enum AntiPatternCase: CaseIterable {
    case glassOnContent
    case glassOnGlass
    case glassBehindButton

    var title: String {
        switch self {
        case .glassOnContent:
            "Glass on content"
        case .glassOnGlass:
            "Glass on glass"
        case .glassBehindButton:
            "Glass behind a plain button"
        }
    }

    var why: String {
        switch self {
        case .glassOnContent:
            """
            Text turns into a floating control and competes with the real ones. Content \
            stays on its own layer.
            """
        case .glassOnGlass:
            """
            Stacked glass doubles refraction and blur, so the inner element loses \
            legibility. One surface per group.
            """
        case .glassBehindButton:
            """
            A glass view behind a button is a static surface. Only the glass \
            configuration gives press feedback.
            """
        }
    }
}

protocol AntiPatternLabViewModelProtocol: AnyObject {
    var title: String { get }
    var backgroundColor: UIColor { get }
    var paragraph: String { get }
    var chips: [String] { get }
    var cases: [AntiPatternCase] { get }
}
