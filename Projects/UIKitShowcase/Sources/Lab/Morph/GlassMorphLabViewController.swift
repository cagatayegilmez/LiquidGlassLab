//
//  GlassMorphLabViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

final class GlassMorphLabViewController: UIViewController {
    private let viewModel: any GlassMorphLabViewModelProtocol

    init(viewModel: any GlassMorphLabViewModelProtocol) {
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
        view = GlassMorphLabView(viewModel: viewModel)
    }
}
