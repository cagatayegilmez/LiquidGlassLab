//
//  DemoTabViewController.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

final class DemoTabViewController: UIViewController, UISearchResultsUpdating {
    private let viewModel: any DemoTabViewModelProtocol
    private let environment: ShowcaseEnvironment

    init(viewModel: any DemoTabViewModelProtocol, environment: ShowcaseEnvironment) {
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
        view = DemoTabView(viewModel: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .switchShowcase(environment: environment)
        if viewModel.isSearchable {
            configureSearch()
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(searchController.searchBar.text ?? "")
    }

    /// Attaches the search controller to the navigation item.
    private func configureSearch() {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Version"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
