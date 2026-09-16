//
//  LabSupport.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit

enum LabSupport {
    /// Pins a content view inside a scroll view with a uniform inset and a matching width.
    ///
    /// - Parameters:
    ///   - content: View to scroll.
    ///   - scrollView: Scroll view that hosts the content.
    ///   - inset: Inset on all four edges.
    static func pin(_ content: UIView, in scrollView: UIScrollView, inset: CGFloat) {
        let guide = scrollView.contentLayoutGuide

        content.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: guide.topAnchor, constant: inset),
            content.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: inset),
            content.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -inset),
            content.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -inset),
            content.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -2 * inset)
        ])
    }

    /// Builds the footnote shown below iOS 26 where only the material fallback is available.
    ///
    /// - Returns: The configured label.
    static func makeLegacyNote() -> UILabel {
        let label = UILabel()

        label.text = "Liquid Glass needs iOS 26. This device shows the material fallback."
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    /// Builds a translucent card that hosts lab controls at the bottom of a screen.
    ///
    /// - Parameter content: Views stacked vertically inside the card.
    /// - Returns: The card view.
    static func makeControlCard(_ content: [UIView]) -> UIView {
        let stack = UIStackView(arrangedSubviews: content)

        stack.axis = .vertical
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stack.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.85)
        stack.layer.cornerRadius = GlassTokens.cornerRadius
        stack.layer.cornerCurve = .continuous
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    /// Builds a compact glass chip that shows a single symbol.
    ///
    /// - Parameter symbolName: SF Symbol name.
    /// - Returns: The chip view.
    static func makeChip(symbolName: String) -> UIView {
        let chip = GlassSurfaceView(cornerRadius: 24)
        let imageView = UIImageView(image: UIImage(systemName: symbolName))

        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title3)
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        chip.contentView.addSubview(imageView)
        chip.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chip.widthAnchor.constraint(equalToConstant: 48),
            chip.heightAnchor.constraint(equalToConstant: 48),
            imageView.centerXAnchor.constraint(equalTo: chip.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: chip.centerYAnchor)
        ])
        return chip
    }
}
