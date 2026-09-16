//
//  GlassTabBarCoordinator.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

final class GlassTabBarCoordinator: NSObject, GlassTabBarViewDelegate, ScrollDirectionObserverDelegate {

    private unowned let tabBarController: UITabBarController
    private let regularTabs: [UITab]
    private let searchTab: UITab?
    private let tabBar: GlassTabBarView
    private let scrollObserver = ScrollDirectionObserver()

    /// Creates the coordinator that replaces the native bar with the glass bar below iOS 26.
    ///
    /// - Parameters:
    ///   - tabBarController: Controller whose tabs the glass bar mirrors.
    ///   - regularTabs: Tabs shown inside the capsule in display order.
    ///   - searchTab: Tab represented by the detached search circle.
    init(tabBarController: UITabBarController,
         regularTabs: [UITab],
         searchTab: UITab?) {
        self.tabBarController = tabBarController
        self.regularTabs = regularTabs
        self.searchTab = searchTab
        self.tabBar = GlassTabBarView(items: regularTabs.map {
            GlassTabBarItem(title: $0.title, image: $0.image)
        })
        super.init()
        tabBar.delegate = self
        scrollObserver.delegate = self
        scrollObserver.ignoredView = tabBar
    }

    /// Hides the native bar, pins the glass bar to the bottom and reserves space for it in every tab.
    func install() {
        let view: UIView = tabBarController.view
        let bottomInset = GlassTabBarView.height + 4

        tabBarController.isTabBarHidden = true
        for tab in regularTabs + [searchTab].compactMap({ $0 }) {
            tab.viewController?.additionalSafeAreaInsets.bottom = bottomInset
        }
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            tabBar.heightAnchor.constraint(equalToConstant: GlassTabBarView.height)
        ])
        scrollObserver.attach(to: view)
        syncSelection()
    }

    /// Mirrors the controller's selected tab on the glass bar and restores the full capsule.
    func syncSelection() {
        let selected = tabBarController.selectedTab
        let index = regularTabs.firstIndex { $0 === selected }

        tabBar.setSelectedIndex(selected === searchTab ? nil : index)
        tabBar.setCollapsed(false, animated: true)
        scrollObserver.reset()
    }

    func glassTabBar(_ tabBar: GlassTabBarView, didSelectItemAt index: Int) {
        guard regularTabs.indices.contains(index) else {
            return
        }
        tabBarController.selectedTab = regularTabs[index]
    }

    func glassTabBarDidSelectSearch(_ tabBar: GlassTabBarView) {
        tabBarController.selectedTab = searchTab
    }

    func scrollDirectionObserver(
        _ observer: ScrollDirectionObserver,
        didDetect direction: ScrollDirection
    ) {
        tabBar.setCollapsed(direction == .down, animated: true)
    }
}
