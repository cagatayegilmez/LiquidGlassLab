//
//  ShowcaseContainerViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import SwiftUIShowcase
import UIKit
import UIKitShowcase

final class ShowcaseContainerViewController: UIViewController {
    private let launchOptions: LaunchOptions
    private var activeShowcase: UIViewController?

    /// Creates the container that hosts one showcase at a time.
    ///
    /// - Parameter launchOptions: Showcase and screen requested through launch arguments.
    init(launchOptions: LaunchOptions) {
        self.launchOptions = launchOptions
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    @available(iOS 27.1, *)
    override var childForPreferredVerticalBarBehavior: UIViewController? {
        activeShowcase
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        show(launchOptions.showcase ?? .swiftui, initialScreen: launchOptions.initialScreen, animated: false)
    }

    /// Replaces the active showcase, cross dissolving when one is already on screen.
    ///
    /// - Parameters:
    ///   - kind: Showcase to present.
    ///   - initialScreen: Screen the showcase should open first.
    ///   - animated: Whether the swap cross dissolves.
    private func show(_ kind: ShowcaseKind, initialScreen: DemoScreen?, animated: Bool) {
        let environment = ShowcaseEnvironment(initialScreen: initialScreen) { [weak self] nextKind in
            self?.show(nextKind, initialScreen: nil, animated: true)
        }
        let next = makeShowcase(kind, environment: environment)

        next.view.frame = view.bounds
        next.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(next)

        guard let previous = activeShowcase, animated else {
            view.addSubview(next.view)
            next.didMove(toParent: self)
            activate(next)
            return
        }

        previous.willMove(toParent: nil)
        transition(from: previous, to: next, duration: 0.35, options: [.transitionCrossDissolve]) {
        } completion: { _ in
            previous.removeFromParent()
            next.didMove(toParent: self)
        }
        activate(next)
    }

    /// Records the showcase on screen and lets the system re-read the bar preferences it forwards.
    ///
    /// - Parameter showcase: Showcase that now owns the screen.
    private func activate(_ showcase: UIViewController) {
        activeShowcase = showcase
        if #available(iOS 27.1, *) {
            setNeedsUpdateOfVerticalBarConfiguration()
        }
    }

    /// Builds the root view controller of a showcase module.
    ///
    /// - Parameters:
    ///   - kind: Showcase to build.
    ///   - environment: Environment handed to the module.
    /// - Returns: The module's root view controller.
    private func makeShowcase(_ kind: ShowcaseKind, environment: ShowcaseEnvironment) -> UIViewController {
        switch kind {
        case .uikit:
            UIKitShowcase.makeRootViewController(environment: environment)
        case .swiftui:
            SwiftUIShowcase.makeRootViewController(environment: environment)
        }
    }
}
