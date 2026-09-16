//
//  AntiPatternLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

final class AntiPatternLabView: UIView {
    private let viewModel: any AntiPatternLabViewModelProtocol

    init(viewModel: any AntiPatternLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = viewModel.backgroundColor
        configureHierarchy()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Scrolls one card per anti-pattern, each pairing a wrong and a better example.
    private func configureHierarchy() {
        let scrollView = UIScrollView()
        let cards = UIStackView(arrangedSubviews: viewModel.cases.map(makeCard))

        if #unavailable(iOS 26) {
            cards.addArrangedSubview(LabSupport.makeLegacyNote())
        }
        cards.axis = .vertical
        cards.spacing = GlassTokens.containerSpacing
        LabSupport.pin(cards, in: scrollView, inset: GlassTokens.spacing)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    /// Builds the card of an anti-pattern with its wrong and better examples.
    ///
    /// - Parameter antiPattern: Case described by the card.
    /// - Returns: The card view.
    private func makeCard(_ antiPattern: AntiPatternCase) -> UIView {
        let wrong: UIView
        let fixed: UIView

        switch antiPattern {
        case .glassOnContent:
            wrong = Self.wrapInGlass(makeParagraph())
            fixed = Self.wrapInCard(makeParagraph())
        case .glassOnGlass:
            wrong = Self.wrapInGlass(makeChipRow())
            fixed = makeChipRow()
        case .glassBehindButton:
            wrong = Self.wrapInGlass(Self.makeConfirmButton(configuration: .plain()))
            fixed = Self.makeConfirmButton(configuration: Self.confirmConfiguration())
        }
        return AntiPatternCardView(title: antiPattern.title, wrong: wrong, fixed: fixed, why: antiPattern.why)
    }

    /// Builds the multi line body text used by the first card.
    ///
    /// - Returns: The label.
    private func makeParagraph() -> UILabel {
        let label = UILabel()

        label.text = viewModel.paragraph
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }

    /// Builds a row of glass chips.
    ///
    /// - Returns: The row view.
    private func makeChipRow() -> UIView {
        let row = UIStackView(arrangedSubviews: viewModel.chips.map(Self.makeChip))

        row.spacing = GlassTokens.spacing
        return row
    }

    /// Builds a single text chip on its own glass surface.
    ///
    /// - Parameter title: Chip text.
    /// - Returns: The chip view.
    private static func makeChip(_ title: String) -> UIView {
        let label = UILabel()

        label.text = title
        label.font = .preferredFont(forTextStyle: .body)
        return wrapInGlass(label, padding: 8)
    }

    /// Puts a view on a glass surface with padding.
    ///
    /// - Parameters:
    ///   - content: View to wrap.
    ///   - padding: Inset between the surface and the content.
    /// - Returns: The glass surface.
    private static func wrapInGlass(_ content: UIView, padding: CGFloat = 16) -> UIView {
        let surface = GlassSurfaceView()

        embed(content, in: surface.contentView, padding: padding)
        return surface
    }

    /// Puts a view on a plain rounded card.
    ///
    /// - Parameter content: View to wrap.
    /// - Returns: The card view.
    private static func wrapInCard(_ content: UIView) -> UIView {
        let card = UIView()

        card.backgroundColor = .systemBackground
        card.layer.cornerRadius = GlassTokens.cornerRadius
        card.layer.cornerCurve = .continuous
        embed(content, in: card, padding: 16)
        return card
    }

    /// Pins a view inside a container with uniform padding.
    ///
    /// - Parameters:
    ///   - content: View to pin.
    ///   - container: View that receives the content.
    ///   - padding: Inset on all four edges.
    private static func embed(_ content: UIView, in container: UIView, padding: CGFloat) {
        content.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            content.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            content.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            content.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding)
        ])
    }

    /// Builds a confirm button with the given configuration and a no-op action.
    ///
    /// - Parameter configuration: Button configuration.
    /// - Returns: The button.
    private static func makeConfirmButton(configuration: UIButton.Configuration) -> UIButton {
        UIButton(configuration: configuration, primaryAction: UIAction(title: "Confirm") { _ in })
    }

    /// Builds the prominent configuration used by the better confirm button.
    ///
    /// - Returns: The configuration.
    private static func confirmConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.adaptiveProminentGlass()

        configuration.cornerStyle = .capsule
        return configuration
    }
}
