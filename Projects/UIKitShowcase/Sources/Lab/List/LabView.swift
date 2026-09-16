//
//  LabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

final class LabView: UIView, UICollectionViewDelegate {
    private let viewModel: any LabViewModelProtocol
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout.list(using: .init(appearance: .insetGrouped))
    )
    private lazy var dataSource = makeDataSource()

    init(viewModel: any LabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureHierarchy()
        apply()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let screen = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        viewModel.select(screen)
    }

    /// Pins the list to all edges.
    private func configureHierarchy() {
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    /// Lists the lab screens provided by the view model.
    private func apply() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, DemoScreen>()

        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.screens)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    /// Builds the list of lab screens with a disclosure indicator per row.
    ///
    /// - Returns: The data source.
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, DemoScreen> {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, DemoScreen> { cell, _, screen in
            var content = cell.defaultContentConfiguration()

            content.text = screen.title
            content.image = UIImage(systemName: screen.symbolName)
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        }

        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, screen in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: screen)
        }
    }
}
