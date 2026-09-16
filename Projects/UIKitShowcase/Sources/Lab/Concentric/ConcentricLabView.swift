//
//  ConcentricLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

final class ConcentricLabView: UIView {
    private let viewModel: any ConcentricLabViewModelProtocol
    private let concentricOuter = UIView()
    private let concentricInner = UIView()
    private let fixedOuter = UIView()
    private let fixedInner = UIView()
    private let radiusLabel = UILabel()
    private let radiusSlider = UISlider()

    init(viewModel: any ConcentricLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = viewModel.backgroundColor
        configureHierarchy()
        ObservationRenderer.render(for: self) { view in
            view.applyRadius()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Places the two cards side by side and the radius card at the bottom.
    private func configureHierarchy() {
        let cards = UIStackView(arrangedSubviews: [
            makeCard(outer: concentricOuter, inner: concentricInner, caption: "Concentric"),
            makeCard(outer: fixedOuter, inner: fixedInner, caption: "Fixed \(Int(viewModel.fixedRadius))pt")
        ])
        let card = LabSupport.makeControlCard([radiusLabel, radiusSlider])

        cards.spacing = GlassTokens.containerSpacing
        cards.distribution = .fillEqually
        cards.translatesAutoresizingMaskIntoConstraints = false
        radiusSlider.minimumValue = 0
        radiusSlider.maximumValue = 64
        radiusSlider.value = Float(viewModel.containerRadius)
        radiusSlider.addAction(UIAction { [weak self] _ in
            guard let self else {
                return
            }
            viewModel.updateRadius(CGFloat(radiusSlider.value))
        }, for: .valueChanged)
        radiusLabel.font = .monospacedDigit(.footnote)
        addSubview(cards)
        addSubview(card)

        NSLayoutConstraint.activate([
            cards.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            cards.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            cards.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            card.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -GlassTokens.spacing)
        ])
    }

    /// Builds a white container with a tinted inner card and a caption below.
    ///
    /// - Parameters:
    ///   - outer: White container view.
    ///   - inner: Tinted inner view.
    ///   - caption: Text under the card.
    /// - Returns: The card column.
    private func makeCard(outer: UIView, inner: UIView, caption: String) -> UIView {
        let label = UILabel()
        let column = UIStackView(arrangedSubviews: [outer, label])
        let inset = viewModel.inset

        outer.backgroundColor = .white
        inner.backgroundColor = GlassTokens.Tint.primaryAction.uiColor
        inner.translatesAutoresizingMaskIntoConstraints = false
        outer.addSubview(inner)
        label.text = caption
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        column.axis = .vertical
        column.spacing = GlassTokens.spacing

        NSLayoutConstraint.activate([
            outer.heightAnchor.constraint(equalToConstant: 120 + 2 * inset),
            inner.topAnchor.constraint(equalTo: outer.topAnchor, constant: inset),
            inner.leadingAnchor.constraint(equalTo: outer.leadingAnchor, constant: inset),
            inner.trailingAnchor.constraint(equalTo: outer.trailingAnchor, constant: -inset),
            inner.bottomAnchor.constraint(equalTo: outer.bottomAnchor, constant: -inset)
        ])
        return column
    }

    /// Applies the view model radius to both containers; only the concentric inner card follows it.
    private func applyRadius() {
        let radius = viewModel.containerRadius
        let fixedRadius = viewModel.fixedRadius

        radiusLabel.text = viewModel.radiusText
        if #available(iOS 26, *) {
            concentricOuter.cornerConfiguration = .uniformCorners(radius: .fixed(radius))
            fixedOuter.cornerConfiguration = .uniformCorners(radius: .fixed(radius))
            concentricInner.cornerConfiguration = .uniformCorners(radius: .containerConcentric())
            fixedInner.cornerConfiguration = .uniformCorners(radius: .fixed(fixedRadius))
        } else {
            concentricOuter.layer.cornerRadius = radius
            fixedOuter.layer.cornerRadius = radius
            concentricInner.layer.cornerRadius = max(radius - viewModel.inset, 0)
            fixedInner.layer.cornerRadius = fixedRadius
        }
    }
}
