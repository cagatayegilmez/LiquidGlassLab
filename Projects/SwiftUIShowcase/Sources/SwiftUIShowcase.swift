//
//  SwiftUIShowcase.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import SwiftUI
import UIKit

public enum SwiftUIShowcase {
    /// Builds the SwiftUI showcase wrapped in a hosting controller.
    ///
    /// - Parameter environment: Initial screen and the showcase switch callback provided by the host.
    /// - Returns: View controller that hosts the showcase.
    public static func makeRootViewController(environment: ShowcaseEnvironment) -> UIViewController {
        UIHostingController(rootView: ShowcaseRootView(environment: environment))
    }
}
