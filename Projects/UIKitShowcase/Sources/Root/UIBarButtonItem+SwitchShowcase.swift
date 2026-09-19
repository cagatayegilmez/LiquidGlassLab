//
//  UIBarButtonItem+SwitchShowcase.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

extension UIBarButtonItem {
    /// Builds the leading bar button that names this showcase and switches to the other one.
    ///
    /// - Parameter environment: Environment carrying the switch callback.
    /// - Returns: The configured bar button item.
    static func switchShowcase(environment: ShowcaseEnvironment) -> UIBarButtonItem {
        let current = ShowcaseKind.uikit
        let action = UIAction(title: current.title) { _ in
            environment.onSwitchShowcase(current.counterpart)
        }
        let item = UIBarButtonItem(primaryAction: action)

        item.accessibilityLabel = "Switch to the \(current.counterpart.title) showcase"
        if #available(iOS 27, *) {
            item.visibilityPriority = .high
        }
        if #available(iOS 27.1, *) {
            item.axisBehavior = .horizontalOnly
        }
        return item
    }
}
