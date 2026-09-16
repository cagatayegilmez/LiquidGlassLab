//
//  GlassSurfaceLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

final class GlassSurfaceLabView: UIView {
    private let viewModel: any GlassSurfaceLabViewModelProtocol
    private let previewSurface = UIVisualEffectView()
    private let controls: GlassSurfaceControlsView
    private lazy var squareConstraint = previewSurface.widthAnchor.constraint(equalTo: previewSurface.heightAnchor)

    init(viewModel: any GlassSurfaceLabViewModelProtocol) {
        self.viewModel = viewModel
        self.controls = GlassSurfaceControlsView(viewModel: viewModel)
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        configureHierarchy()
        ObservationRenderer.render(for: self) { view in
            view.applyEffect()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Splits the screen into the colored preview on top and the control form below.
    private func configureHierarchy() {
        let previewArea = UIView()
        let label = UILabel()
        let icon = UIImageView(image: UIImage(systemName: "drop.fill"))
        let content = UIStackView(arrangedSubviews: [icon, label])

        previewArea.backgroundColor = viewModel.backgroundColor
        label.text = "Liquid Glass"
        label.font = .preferredFont(forTextStyle: .title2).withWeight(.bold)
        icon.tintColor = .label
        content.spacing = 8
        content.alignment = .center
        content.translatesAutoresizingMaskIntoConstraints = false
        previewSurface.contentView.addSubview(content)
        previewSurface.translatesAutoresizingMaskIntoConstraints = false
        previewArea.translatesAutoresizingMaskIntoConstraints = false
        controls.translatesAutoresizingMaskIntoConstraints = false
        previewArea.addSubview(previewSurface)
        addSubview(previewArea)
        addSubview(controls)

        let surfaceContent = previewSurface.contentView
        let padding = GlassTokens.containerSpacing

        NSLayoutConstraint.activate([
            previewArea.topAnchor.constraint(equalTo: topAnchor),
            previewArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewSurface.centerXAnchor.constraint(equalTo: previewArea.centerXAnchor),
            previewSurface.centerYAnchor.constraint(equalTo: previewArea.safeAreaLayoutGuide.centerYAnchor),
            content.topAnchor.constraint(equalTo: surfaceContent.topAnchor, constant: padding),
            content.leadingAnchor.constraint(equalTo: surfaceContent.leadingAnchor, constant: padding),
            content.trailingAnchor.constraint(equalTo: surfaceContent.trailingAnchor, constant: -padding),
            content.bottomAnchor.constraint(equalTo: surfaceContent.bottomAnchor, constant: -padding),
            controls.topAnchor.constraint(equalTo: previewArea.bottomAnchor),
            controls.leadingAnchor.constraint(equalTo: leadingAnchor),
            controls.trailingAnchor.constraint(equalTo: trailingAnchor),
            controls.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    /// Rebuilds the effect from the view model state; below iOS 26 a blur stands in for glass.
    private func applyEffect() {
        let isRoundedRectangle = viewModel.shape == .roundedRectangle

        squareConstraint.isActive = viewModel.shape == .circle
        if #available(iOS 26, *) {
            previewSurface.effect = makeGlassEffect()
            previewSurface.cornerConfiguration = isRoundedRectangle
                ? .uniformCorners(radius: .fixed(GlassTokens.cornerRadius))
                : .capsule()
        } else {
            previewSurface.effect = UIBlurEffect(style: .systemUltraThinMaterial)
            previewSurface.layer.cornerRadius = isRoundedRectangle ? GlassTokens.cornerRadius : 40
            previewSurface.clipsToBounds = true
        }
    }

    /// Builds the glass effect for the picked variant, or nil for the identity variant.
    ///
    /// - Returns: The effect to install on the preview.
    @available(iOS 26, *)
    private func makeGlassEffect() -> UIVisualEffect? {
        guard viewModel.variant != .identity else {
            return nil
        }
        let glass = UIGlassEffect(style: viewModel.variant == .clear ? .clear : .regular)

        glass.isInteractive = viewModel.isInteractive
        glass.tintColor = viewModel.tint.tint?.uiColor
        return glass
    }
}
