//
//  AntiPatternLabViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

final class AntiPatternLabViewController: UIViewController {
    private let viewModel: any AntiPatternLabViewModelProtocol

    init(viewModel: any AntiPatternLabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .never
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func loadView() {
        view = AntiPatternLabView(viewModel: viewModel)
    }
}
