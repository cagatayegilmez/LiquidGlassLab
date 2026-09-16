//
//  ShowcaseRootView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import SwiftUI

struct ShowcaseRootView: View {
    @State private var coordinator: ShowcaseCoordinator

    init(environment: ShowcaseEnvironment) {
        coordinator = ShowcaseCoordinator(
            initialScreen: environment.initialScreen,
            switchShowcase: environment.onSwitchShowcase
        )
    }

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            Tab(DemoScreen.portfolio.title, systemImage: DemoScreen.portfolio.symbolName, value: .portfolio) {
                DemoTabView(screen: .portfolio)
            }
            Tab(DemoScreen.market.title, systemImage: DemoScreen.market.symbolName, value: .market) {
                DemoTabView(screen: .market)
            }
            Tab("Lab", systemImage: "flask", value: .lab) {
                LabView()
            }
            Tab(DemoScreen.trade.title, systemImage: DemoScreen.trade.symbolName, value: .trade, role: tradeRole) {
                DemoTabView(screen: .trade)
            }
            Tab(value: .search, role: .search) {
                DemoTabView(screen: .search)
            }
        }
        .modifier(TabBarMinimizeModifier())
        .environment(coordinator)
    }

    private var tradeRole: TabRole? {
        if #available(iOS 27, *) {
            .prominent
        } else {
            nil
        }
    }
}

struct TabBarMinimizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.tabBarMinimizeBehavior(.onScrollDown)
        } else {
            content
        }
    }
}
