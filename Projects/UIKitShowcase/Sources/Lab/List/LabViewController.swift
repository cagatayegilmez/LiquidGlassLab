//
//  LabViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

final class LabViewController: UIViewController {
    private let viewModel: any LabViewModelProtocol
    private let environment: ShowcaseEnvironment

    init(viewModel: any LabViewModelProtocol, environment: ShowcaseEnvironment) {
        self.viewModel = viewModel
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func loadView() {
        view = LabView(viewModel: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = .switchShowcase(environment: environment)
    }
}
