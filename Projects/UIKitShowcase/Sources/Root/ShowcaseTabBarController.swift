//
//  ShowcaseTabBarController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit

final class ShowcaseTabBarController: UITabBarController {
    private let environment: ShowcaseEnvironment
    private let regularTabs: [UITab]
    private let searchTab: UISearchTab
    private var glassTabBarCoordinator: GlassTabBarCoordinator?

    override var selectedTab: UITab? {
        get {
            super.selectedTab
        }
        set {
            super.selectedTab = newValue
            glassTabBarCoordinator?.syncSelection()
        }
    }

    /// Creates the tab bar with one tab per demo area.
    ///
    /// - Parameter environment: Initial screen and the showcase switch callback provided by the host.
    init(environment: ShowcaseEnvironment) {
        self.environment = environment
        self.regularTabs = Self.makeTabs(environment: environment)
        self.searchTab = UISearchTab { _ in
            UINavigationController(rootViewController: DemoTabBuilder.build(screen: .search, environment: environment))
        }
        super.init(nibName: nil, bundle: nil)
        tabs = regularTabs + [searchTab]
        configureChrome()
        openInitialScreen()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #unavailable(iOS 26) {
            installGlassTabBar()
        }
    }

    /// Swaps the native bar for the glass capsule that mimics the iOS 26 look on older systems.
    private func installGlassTabBar() {
        let coordinator = GlassTabBarCoordinator(
            tabBarController: self,
            regularTabs: regularTabs,
            searchTab: searchTab
        )

        coordinator.install()
        glassTabBarCoordinator = coordinator
    }

    /// Builds the regular tabs; the search tab is created separately because it has a fixed role.
    ///
    /// - Parameter environment: Environment handed to every root view controller.
    /// - Returns: Portfolio, market, lab and trade tabs in display order.
    private static func makeTabs(environment: ShowcaseEnvironment) -> [UITab] {
        let lab = UITab(title: "Lab", image: UIImage(systemName: "flask"), identifier: Self.labTabIdentifier) { _ in
            UINavigationController(rootViewController: LabBuilder.build(environment: environment))
        }

        return [
            makeTab(for: .portfolio, environment: environment),
            makeTab(for: .market, environment: environment),
            lab,
            makeTab(for: .trade, environment: environment)
        ]
    }

    /// Builds a tab that hosts the demo screen inside a navigation controller.
    ///
    /// - Parameters:
    ///   - screen: Screen shown by the tab.
    ///   - environment: Environment handed to the root view controller.
    /// - Returns: The tab.
    private static func makeTab(for screen: DemoScreen, environment: ShowcaseEnvironment) -> UITab {
        UITab(title: screen.title, image: UIImage(systemName: screen.symbolName), identifier: screen.rawValue) { _ in
            UINavigationController(rootViewController: DemoTabBuilder.build(screen: screen, environment: environment))
        }
    }

    /// Enables the tab bar behaviors this showcase demonstrates.
    private func configureChrome() {
        if #available(iOS 26, *) {
            tabBarMinimizeBehavior = .onScrollDown
        }
        if #available(iOS 27, *) {
            prominentTabIdentifier = DemoScreen.trade.rawValue
        }
    }

    /// Selects the tab for the launch screen and pushes the lab screen when one was requested.
    private func openInitialScreen() {
        guard let screen = environment.initialScreen else {
            return
        }
        selectedTab = screen == .search ? searchTab : tabs.first { $0.identifier == Self.tabIdentifier(for: screen) }

        if let navigation = selectedTab?.viewController as? UINavigationController,
           let controller = LabScreenFactory.makeViewController(for: screen) {
            navigation.pushViewController(controller, animated: false)
        }
    }

    private static let labTabIdentifier = "lab"

    /// Maps a demo screen to the identifier of the tab that hosts it.
    ///
    /// - Parameter screen: Screen requested at launch.
    /// - Returns: Identifier of the matching tab.
    private static func tabIdentifier(for screen: DemoScreen) -> String {
        screen.isLab ? labTabIdentifier : screen.rawValue
    }
}
