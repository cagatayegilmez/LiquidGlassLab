//
//  GlassMorphLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

final class GlassMorphLabView: UIView {
    private let viewModel: any GlassMorphLabViewModelProtocol
    private let containerView = UIVisualEffectView()
    private let chipsRow = UIStackView()
    private let toggleButton = UIButton(configuration: .adaptiveGlass())
    private let spacingLabel = UILabel()
    private let spacingSlider = UISlider()

    init(viewModel: any GlassMorphLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = viewModel.backgroundColor
        configureHierarchy()
        ObservationRenderer.render(for: self) { view in
            view.apply()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Centers the morphing controls and pins the spacing card to the bottom.
    private func configureHierarchy() {
        let actions = viewModel.actionSymbols.map(LabSupport.makeChip(symbolName:))
        let segmentRow = UIStackView(arrangedSubviews: viewModel.segments.map(Self.makeSegment))
        let column = UIStackView(arrangedSubviews: [chipsRow, segmentRow])
        let card = LabSupport.makeControlCard([spacingLabel, spacingSlider])

        for chip in actions {
            chip.isHidden = true
            chipsRow.addArrangedSubview(chip)
        }
        toggleButton.configuration?.cornerStyle = .capsule
        toggleButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.toggleExpanded()
        }, for: .primaryActionTriggered)
        chipsRow.addArrangedSubview(toggleButton)
        chipsRow.spacing = GlassTokens.spacing
        chipsRow.alignment = .center
        segmentRow.spacing = 8
        column.axis = .vertical
        column.alignment = .center
        column.spacing = GlassTokens.containerSpacing
        column.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.contentView.addSubview(column)
        addSubview(containerView)
        addSubview(card)
        spacingSlider.minimumValue = 0
        spacingSlider.maximumValue = 80
        spacingSlider.value = Float(viewModel.spacing)
        spacingSlider.addAction(UIAction { [weak self] _ in
            guard let self else {
                return
            }
            viewModel.updateSpacing(CGFloat(spacingSlider.value))
        }, for: .valueChanged)
        spacingLabel.font = .monospacedDigit(.footnote)

        NSLayoutConstraint.activate([
            toggleButton.widthAnchor.constraint(equalToConstant: 48),
            toggleButton.heightAnchor.constraint(equalToConstant: 48),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            column.topAnchor.constraint(equalTo: containerView.contentView.topAnchor),
            column.leadingAnchor.constraint(equalTo: containerView.contentView.leadingAnchor),
            column.trailingAnchor.constraint(equalTo: containerView.contentView.trailingAnchor),
            column.bottomAnchor.constraint(equalTo: containerView.contentView.bottomAnchor),
            card.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -GlassTokens.spacing)
        ])
    }

    /// Copies the view model state into the chips, the toggle and the container effect.
    private func apply() {
        let isExpanded = viewModel.isExpanded
        let spacing = viewModel.spacing

        toggleButton.configuration?.image = UIImage(systemName: viewModel.toggleSymbolName)
        spacingLabel.text = viewModel.spacingText
        if chipsRow.arrangedSubviews.dropLast().contains(where: { $0.isHidden == isExpanded }) {
            UIView.animate(springDuration: 0.5, bounce: 0.3) { [chipsRow] in
                for chip in chipsRow.arrangedSubviews.dropLast() {
                    chip.isHidden = !isExpanded
                }
            }
        }
        if #available(iOS 26, *) {
            let container = UIGlassContainerEffect()

            container.spacing = spacing
            containerView.effect = container
        }
    }

    /// Builds one segment chip for the union example.
    ///
    /// - Parameter title: Segment text.
    /// - Returns: The chip view.
    private static func makeSegment(_ title: String) -> UIView {
        let chip = GlassSurfaceView(cornerRadius: 18)
        let label = UILabel()

        label.text = title
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        chip.contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: chip.contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: chip.contentView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: chip.contentView.leadingAnchor, constant: GlassTokens.spacing),
            label.trailingAnchor.constraint(equalTo: chip.contentView.trailingAnchor, constant: -GlassTokens.spacing)
        ])
        return chip
    }
}
