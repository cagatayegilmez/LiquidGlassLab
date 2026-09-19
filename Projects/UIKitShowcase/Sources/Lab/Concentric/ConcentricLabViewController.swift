//
//  ConcentricLabViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import UIKit

final class ConcentricLabViewController: UIViewController {
    private let viewModel: any ConcentricLabViewModelProtocol

    init(viewModel: any ConcentricLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .never
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    @available(iOS 27.1, *)
    override var preferredVerticalBarBehavior: UIVerticalBarBehavior {
        .disabled
    }

    override func loadView() {
        view = ConcentricLabView(viewModel: viewModel)
    }
}
