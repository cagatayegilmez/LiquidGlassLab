//
//  GlassButtonsLabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit

final class GlassButtonsLabView: UIView {
    private let viewModel: any GlassButtonsLabViewModelProtocol

    init(viewModel: any GlassButtonsLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = viewModel.backgroundColor
        configureHierarchy()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Stacks one row per corner style inside a scroll view.
    private func configureHierarchy() {
        let scrollView = UIScrollView()
        let rows = UIStackView(arrangedSubviews: viewModel.rows.map(makeRow))

        if #unavailable(iOS 26) {
            rows.addArrangedSubview(LabSupport.makeLegacyNote())
        }
        rows.axis = .vertical
        rows.spacing = GlassTokens.containerSpacing
        LabSupport.pin(rows, in: scrollView, inset: GlassTokens.spacing)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    /// Builds a titled row that pairs every sample with one corner style.
    ///
    /// - Parameter row: Row description from the view model.
    /// - Returns: The row view.
    private func makeRow(_ row: GlassButtonRow) -> UIView {
        let label = UILabel()
        let buttons = UIStackView(arrangedSubviews: viewModel.samples.map { makeButton($0, in: row) })
        let column = UIStackView(arrangedSubviews: [label, buttons])

        label.text = row.title
        label.font = .preferredFont(forTextStyle: .headline)
        buttons.spacing = GlassTokens.spacing
        buttons.alignment = .leading
        column.axis = .vertical
        column.alignment = .leading
        column.spacing = GlassTokens.spacing
        return column
    }

    /// Builds one sample button in the corner style of its row.
    ///
    /// - Parameters:
    ///   - sample: Sample description from the view model.
    ///   - row: Row that provides the corner style and icon only flag.
    /// - Returns: The configured button.
    private func makeButton(_ sample: GlassButtonSample, in row: GlassButtonRow) -> UIButton {
        var configuration: UIButton.Configuration = sample.isProminent ? .adaptiveProminentGlass() : .adaptiveGlass()

        configuration.title = row.isIconOnly ? nil : sample.title
        configuration.image = UIImage(systemName: sample.symbolName)
        configuration.imagePadding = 4
        configuration.titleLineBreakMode = .byClipping
        configuration.cornerStyle = row.cornerStyle
        if row.cornerStyle == .fixed {
            configuration.background.cornerRadius = 12
        }

        let button = UIButton(configuration: configuration)

        if let tint = sample.tint {
            button.tintColor = tint.uiColor
        }
        return button
    }
}
