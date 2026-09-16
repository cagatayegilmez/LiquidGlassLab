//
//  GlassSurfaceView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import UIKit

public final class GlassSurfaceView: UIView {

    public var contentView: UIView {
        effectView.contentView
    }

    private let effectView = UIVisualEffectView()
    private let tint: GlassTokens.Tint?
    private let isInteractive: Bool
    private let cornerRadius: CGFloat

    /// Creates a glass surface that hosts its content inside `contentView`.
    ///
    /// - Parameters:
    ///   - tint: Semantic tint mixed into the surface.
    ///   - interactive: Whether the surface reacts to touches.
    ///   - cornerRadius: Radius applied to all four corners.
    public init(
        tint: GlassTokens.Tint? = nil,
        interactive: Bool = false,
        cornerRadius: CGFloat = GlassTokens.cornerRadius
    ) {
        self.tint = tint
        self.isInteractive = interactive
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        configureHierarchy()
        applyEffect()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyEffect),
            name: UIAccessibility.reduceTransparencyStatusDidChangeNotification,
            object: nil
        )
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Pins the effect view to all edges so the glass fills the surface.
    private func configureHierarchy() {
        effectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(effectView)
        NSLayoutConstraint.activate([
            effectView.topAnchor.constraint(equalTo: topAnchor),
            effectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            effectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    /// Installs the glass effect on iOS 26 and a material or solid fallback below it.
    @objc
    private func applyEffect() {
        if #available(iOS 26, *) {
            let glass = UIGlassEffect(style: .regular)
            glass.isInteractive = isInteractive
            glass.tintColor = tint?.uiColor
            effectView.effect = glass
            effectView.cornerConfiguration = .uniformCorners(radius: .fixed(cornerRadius))
        } else if UIAccessibility.isReduceTransparencyEnabled {
            effectView.effect = nil
            effectView.contentView.backgroundColor = .secondarySystemBackground
            roundLegacyCorners()
        } else {
            effectView.effect = UIBlurEffect(style: .systemUltraThinMaterial)
            effectView.contentView.backgroundColor = nil
            roundLegacyCorners()
        }
    }

    /// Clips the effect view with a plain corner radius where corner configuration is unavailable.
    private func roundLegacyCorners() {
        effectView.layer.cornerRadius = cornerRadius
        effectView.layer.cornerCurve = .continuous
        effectView.clipsToBounds = true
    }
}
