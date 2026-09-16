//
//  GlassSurfaceLabViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import UIKit

final class GlassSurfaceLabViewController: UIViewController {
    private let viewModel: any GlassSurfaceLabViewModelProtocol

    init(viewModel: any GlassSurfaceLabViewModelProtocol) {
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
        view = GlassSurfaceLabView(viewModel: viewModel)
    }
}
