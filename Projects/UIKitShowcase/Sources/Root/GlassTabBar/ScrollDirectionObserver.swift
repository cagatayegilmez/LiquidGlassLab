//
//  ScrollDirectionObserver.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

protocol ScrollDirectionObserverDelegate: AnyObject {

    /// Notifies that the vertical scroll direction changed.
    ///
    /// - Parameters:
    ///   - observer: Observer sending the event.
    ///   - direction: Newly detected direction.
    func scrollDirectionObserver(
        _ observer: ScrollDirectionObserver,
        didDetect direction: ScrollDirection
    )
}

enum ScrollDirection {
    case down
    case up
}

final class ScrollDirectionObserver: NSObject, UIGestureRecognizerDelegate {

    weak var delegate: (any ScrollDirectionObserverDelegate)?
    weak var ignoredView: UIView?

    private weak var hostView: UIView?
    private var lastTranslationY: CGFloat = 0
    private var accumulatedDistance: CGFloat = 0
    private var reportedDirection: ScrollDirection?
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))

        recognizer.cancelsTouchesInView = false
        recognizer.delaysTouchesBegan = false
        recognizer.delaysTouchesEnded = false
        recognizer.delegate = self
        return recognizer
    }()

    /// Starts watching vertical pans anywhere inside the view.
    ///
    /// - Parameter view: Host view whose scroll views are tracked.
    func attach(to view: UIView) {
        hostView = view
        view.addGestureRecognizer(panRecognizer)
    }

    /// Forgets the last reported direction so the next scroll reports again.
    func reset() {
        reportedDirection = nil
        accumulatedDistance = 0
    }

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touched = touch.view, !touched.isDescendant(of: ignoredView ?? UIView()) else {
            return false
        }
        return Self.canScrollVertically(from: touched)
    }

    @objc
    private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translationY = recognizer.translation(in: hostView).y

        switch recognizer.state {
        case .began:
            lastTranslationY = translationY
            accumulatedDistance = 0
        case .changed:
            accumulate(translationY - lastTranslationY)
            lastTranslationY = translationY
        default:
            break
        }
    }

    /// Buffers finger movement and reports a direction once it passes the trigger distance.
    ///
    /// - Parameter delta: Vertical finger movement since the previous event.
    private func accumulate(_ delta: CGFloat) {
        guard delta != 0 else {
            return
        }
        if (delta > 0) != (accumulatedDistance > 0) {
            accumulatedDistance = 0
        }
        accumulatedDistance += delta

        if accumulatedDistance <= -24 {
            report(.down)
        } else if accumulatedDistance >= 12 {
            report(.up)
        }
    }

    /// Forwards a direction to the delegate only when it differs from the last one.
    ///
    /// - Parameter direction: Direction to report.
    private func report(_ direction: ScrollDirection) {
        guard reportedDirection != direction else {
            return
        }
        
        reportedDirection = direction
        delegate?.scrollDirectionObserver(self, didDetect: direction)
    }

    /// Tells whether some ancestor scroll view of the touched view has room to scroll vertically.
    ///
    /// - Parameter view: View the touch landed on.
    /// - Returns: `true` when a vertically scrollable scroll view contains the view.
    private static func canScrollVertically(from view: UIView) -> Bool {
        var current: UIView? = view

        while let candidate = current {
            if let scrollView = candidate as? UIScrollView, scrollView.isScrollEnabled {
                let insets = scrollView.adjustedContentInset
                let scrollableHeight = scrollView.contentSize.height + insets.top + insets.bottom

                if scrollableHeight > scrollView.bounds.height + 1 {
                    return true
                }
            }
            current = candidate.superview
        }
        return false
    }
}
