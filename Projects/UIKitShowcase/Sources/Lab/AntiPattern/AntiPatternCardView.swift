//
//  AntiPatternCardView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

final class AntiPatternCardView: UIView {
    /// Builds a card that shows the wrong example above the better one with an explanation.
    ///
    /// - Parameters:
    ///   - title: Card title.
    ///   - wrong: View demonstrating the anti-pattern.
    ///   - fixed: View demonstrating the recommended approach.
    ///   - why: Short explanation of the problem.
    init(title: String, wrong: UIView, fixed: UIView, why: String) {
        super.init(frame: .zero)

        let stack = UIStackView(arrangedSubviews: [
            Self.makeLabel(title, style: .headline, color: .label),
            Self.makeLabel("Wrong", style: .caption1, color: GlassTokens.Tint.negative.uiColor),
            Self.leadingAligned(wrong),
            Self.makeLabel("Better", style: .caption1, color: GlassTokens.Tint.positive.uiColor),
            Self.leadingAligned(fixed),
            Self.makeLabel(why, style: .footnote, color: .secondaryLabel)
        ])

        backgroundColor = UIColor.systemBackground.withAlphaComponent(0.85)
        layer.cornerRadius = GlassTokens.cornerRadius
        layer.cornerCurve = .continuous
        stack.axis = .vertical
        stack.spacing = GlassTokens.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Builds a multi line label in the given text style and color.
    ///
    /// - Parameters:
    ///   - text: Label text.
    ///   - style: Dynamic type text style.
    ///   - color: Text color.
    /// - Returns: The label.
    private static func makeLabel(_ text: String, style: UIFont.TextStyle, color: UIColor) -> UILabel {
        let label = UILabel()

        label.text = text
        label.font = .preferredFont(forTextStyle: style)
        label.textColor = color
        label.numberOfLines = 0
        return label
    }

    /// Keeps an example hugging the leading edge instead of stretching across the card.
    ///
    /// - Parameter example: Example view.
    /// - Returns: A horizontal stack that pads the trailing side.
    private static func leadingAligned(_ example: UIView) -> UIView {
        let row = UIStackView(arrangedSubviews: [example, UIView()])

        row.alignment = .top
        return row
    }
}
