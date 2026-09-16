//
//  GlassTabItemView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

struct GlassTabBarItem {

    let title: String
    let image: UIImage?
}

final class GlassTabItemView: UIControl {
    private let iconView = UIImageView()
    private let titleLabel = UILabel()

    override var isSelected: Bool {
        didSet {
            applySelection()
        }
    }

    init(item: GlassTabBarItem) {
        super.init(frame: .zero)
        configureHierarchy(item: item)
        applySelection()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        applySelection()
    }

    /// Stacks the symbol over the title and exposes the control as a tab to accessibility.
    ///
    /// - Parameter item: Title and image of the tab.
    private func configureHierarchy(item: GlassTabBarItem) {
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])

        iconView.image = item.image
        iconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        iconView.contentMode = .scaleAspectFit
        titleLabel.text = item.title
        titleLabel.font = .systemFont(ofSize: 10, weight: .medium)
        titleLabel.textAlignment = .center
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        isAccessibilityElement = true
        accessibilityLabel = item.title

        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: 64),
            iconView.heightAnchor.constraint(equalToConstant: 26),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 12)
        ])
    }

    /// Colors the symbol and title with the tint when selected and with the label color otherwise.
    private func applySelection() {
        let color = isSelected ? tintColor ?? .systemBlue : .label

        iconView.tintColor = color
        titleLabel.textColor = color
        accessibilityTraits = isSelected ? [.button, .selected] : [.button]
    }
}
