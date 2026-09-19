//
//  DemoTabView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit

final class DemoTabView: UIView {
    private let viewModel: any DemoTabViewModelProtocol
    private let collectionView: UICollectionView
    private lazy var dataSource = makeDataSource()

    init(viewModel: any DemoTabViewModelProtocol) {
        self.viewModel = viewModel
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.makeLayout())
        super.init(frame: .zero)
        configureHierarchy()
        ObservationRenderer.render(for: self) { view in
            view.apply()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    /// Pins the list to all edges and registers the headline header.
    private func configureHierarchy() {
        let header = UICollectionView.SupplementaryRegistration<DemoTabHeadlineView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { [weak self] view, _, _ in
            view.configure(text: self?.viewModel.headline ?? "")
        }

        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
        }
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    /// Copies the view model state into the background and the list.
    private func apply() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, IOSRelease>()

        backgroundColor = viewModel.backgroundColor
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.releases)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    /// Builds a plain list whose section header takes half of the visible height so the headline sits above the fold.
    ///
    /// - Returns: The compositional layout.
    private static func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, environment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)

            configuration.backgroundColor = .clear
            configuration.separatorConfiguration.color = .white.withAlphaComponent(0.4)

            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(
                    environment.container.effectiveContentSize.height * GlassTokens.headlineHeightFraction
                )
            )

            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            return section
        }
    }

    /// Builds the diffable data source that renders one value cell per release.
    ///
    /// - Returns: The data source.
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, IOSRelease> {
        typealias Registration = UICollectionView.CellRegistration<UICollectionViewListCell, IOSRelease>

        let registration = Registration { cell, _, release in
            var content = UIListContentConfiguration.valueCell()

            content.text = release.name
            content.secondaryText = String(release.year)
            content.textProperties.color = .white
            content.textProperties.font = .preferredFont(forTextStyle: .headline)
            content.secondaryTextProperties.color = .white
            content.secondaryTextProperties.font = .monospacedDigit(.subheadline)
            cell.contentConfiguration = content
            cell.backgroundConfiguration = .clear()
        }

        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
        }
    }
}
