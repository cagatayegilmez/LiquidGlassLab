//
//  GlassSurfaceControlsView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

final class GlassSurfaceControlsView: UIView {
    private let viewModel: any GlassSurfaceLabViewModelProtocol
    private let variantControl = UISegmentedControl(items: GlassVariant.allCases.map(\.title))
    private let tintControl = UISegmentedControl(items: TintChoice.allCases.map(\.title))
    private let interactiveSwitch = UISwitch()
    private let shapeControl = UISegmentedControl(items: SurfaceShape.allCases.map(\.title))

    init(viewModel: any GlassSurfaceLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureHierarchy()
        configureActions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Stacks the four controls in a grouped form look, preselecting the view model state.
    private func configureHierarchy() {
        backgroundColor = .systemGroupedBackground
        variantControl.selectedSegmentIndex = viewModel.variant.rawValue
        tintControl.selectedSegmentIndex = viewModel.tint.rawValue
        shapeControl.selectedSegmentIndex = viewModel.shape.rawValue
        interactiveSwitch.isOn = viewModel.isInteractive

        let interactiveRow = UIStackView(arrangedSubviews: [Self.makeLabel("Interactive"), interactiveSwitch])
        let stack = UIStackView(arrangedSubviews: [variantControl, tintControl, interactiveRow, shapeControl])
        let padding = GlassTokens.containerSpacing

        interactiveRow.alignment = .center
        stack.axis = .vertical
        stack.spacing = GlassTokens.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }

    /// Forwards every control change to the view model.
    private func configureActions() {
        variantControl.addAction(UIAction { [weak self] _ in
            guard let self, let variant = GlassVariant(rawValue: variantControl.selectedSegmentIndex) else {
                return
            }
            viewModel.select(variant)
        }, for: .valueChanged)
        tintControl.addAction(UIAction { [weak self] _ in
            guard let self, let tint = TintChoice(rawValue: tintControl.selectedSegmentIndex) else {
                return
            }
            viewModel.select(tint)
        }, for: .valueChanged)
        shapeControl.addAction(UIAction { [weak self] _ in
            guard let self, let shape = SurfaceShape(rawValue: shapeControl.selectedSegmentIndex) else {
                return
            }
            viewModel.select(shape)
        }, for: .valueChanged)
        interactiveSwitch.addAction(UIAction { [weak self] _ in
            guard let self else {
                return
            }
            viewModel.setInteractive(interactiveSwitch.isOn)
        }, for: .valueChanged)
    }

    /// Builds a body text label.
    ///
    /// - Parameter text: Label text.
    /// - Returns: The label.
    private static func makeLabel(_ text: String) -> UILabel {
        let label = UILabel()

        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }
}
