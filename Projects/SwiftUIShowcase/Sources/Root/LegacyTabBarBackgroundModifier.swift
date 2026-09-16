//
//  LegacyTabBarBackgroundModifier.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import SwiftUI

struct LegacyTabBarBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
        } else {
            content
                .toolbarBackground(Color(uiColor: GlassTokens.legacyBarBackground), for: .tabBar)
                .toolbarBackgroundVisibility(.visible, for: .tabBar)
        }
    }
}
