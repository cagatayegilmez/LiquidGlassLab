//
//  GlassTabBarView.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import UIKit

protocol GlassTabBarViewDelegate: AnyObject {

    /// Notifies that a capsule item was tapped.
    ///
    /// - Parameters:
    ///   - tabBar: Bar sending the event.
    ///   - index: Index of the item inside the capsule.
    func glassTabBar(_ tabBar: GlassTabBarView, didSelectItemAt index: Int)

    /// Notifies that the detached search circle was tapped.
    ///
    /// - Parameter tabBar: Bar sending the event.
    func glassTabBarDidSelectSearch(_ tabBar: GlassTabBarView)
}

final class GlassTabBarView: UIView {
    static let height: CGFloat = 64

    weak var delegate: (any GlassTabBarViewDelegate)?

    private(set) var selectedIndex: Int?
    private(set) var isCollapsed = false

    private let capsule = GlassTabBarView.makeSurface()
    private let searchCircle = GlassTabBarView.makeSurface()
    private let selectionPill = UIView()
    private let itemsStack = UIStackView()
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    private var itemViews: [GlassTabItemView] = []
    private lazy var expandedTrailing = searchCircle.leadingAnchor.constraint(
        equalTo: capsule.trailingAnchor,
        constant: 8
    )

    /// Creates the bar with one capsule item per tab and a detached search circle.
    ///
    /// - Parameter items: Titles and images of the capsule items in display order.
    init(items: [GlassTabBarItem]) {
        super.init(frame: .zero)
        itemViews = items.map(GlassTabItemView.init(item:))
        configureHierarchy()
        configureActions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        capsule.layer.cornerRadius = capsule.bounds.height / 2
        searchCircle.layer.cornerRadius = searchCircle.bounds.height / 2
        moveSelectionPill(animated: false)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        capsule.frame.contains(point) || searchCircle.frame.contains(point)
    }

    /// Highlights a capsule item, or the search circle when the index is nil.
    ///
    /// - Parameter index: Index of the selected item.
    func setSelectedIndex(_ index: Int?) {
        selectedIndex = index
        for (itemIndex, itemView) in itemViews.enumerated() {
            itemView.isSelected = itemIndex == index
        }
        searchIcon.tintColor = index == nil ? tintColor : .label
        moveSelectionPill(animated: true)
    }

    /// Shrinks the capsule down to the selected item or restores every item.
    ///
    /// - Parameters:
    ///   - collapsed: Whether only the selected item stays visible.
    ///   - animated: Whether the change springs into place.
    func setCollapsed(_ collapsed: Bool, animated: Bool) {
        guard collapsed != isCollapsed, selectedIndex != nil || !collapsed else {
            return
        }
        isCollapsed = collapsed
        expandedTrailing.isActive = !collapsed

        let changes = {
            for (index, itemView) in self.itemViews.enumerated() {
                itemView.isHidden = collapsed && index != self.selectedIndex
            }
            self.layoutIfNeeded()
        }

        if animated {
            UIView.animate(springDuration: 0.45, bounce: 0.2, options: [.allowUserInteraction], animations: changes)
        } else {
            changes()
        }
    }

    /// Lays out the capsule at the leading edge and the search circle at the trailing edge.
    private func configureHierarchy() {
        selectionPill.backgroundColor = .systemFill
        searchIcon.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        searchIcon.tintColor = .label
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        itemsStack.distribution = .fillEqually
        itemsStack.translatesAutoresizingMaskIntoConstraints = false
        for itemView in itemViews {
            itemsStack.addArrangedSubview(itemView)
        }
        capsule.contentView.addSubview(selectionPill)
        capsule.contentView.addSubview(itemsStack)
        searchCircle.contentView.addSubview(searchIcon)
        addSubview(capsule)
        addSubview(searchCircle)

        NSLayoutConstraint.activate([
            capsule.leadingAnchor.constraint(equalTo: leadingAnchor),
            capsule.topAnchor.constraint(equalTo: topAnchor),
            capsule.bottomAnchor.constraint(equalTo: bottomAnchor),
            expandedTrailing,
            searchCircle.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchCircle.topAnchor.constraint(equalTo: topAnchor),
            searchCircle.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchCircle.widthAnchor.constraint(equalTo: searchCircle.heightAnchor),
            searchIcon.centerXAnchor.constraint(equalTo: searchCircle.centerXAnchor),
            searchIcon.centerYAnchor.constraint(equalTo: searchCircle.centerYAnchor),
            itemsStack.leadingAnchor.constraint(equalTo: capsule.contentView.leadingAnchor, constant: 4),
            itemsStack.trailingAnchor.constraint(equalTo: capsule.contentView.trailingAnchor, constant: -4),
            itemsStack.topAnchor.constraint(equalTo: capsule.contentView.topAnchor),
            itemsStack.bottomAnchor.constraint(equalTo: capsule.contentView.bottomAnchor)
        ])
    }

    /// Wires item taps and the search tap to the delegate.
    private func configureActions() {
        for itemView in itemViews {
            itemView.addAction(UIAction { [weak self] action in
                guard let self, let sender = action.sender as? GlassTabItemView else {
                    return
                }
                didTap(sender)
            }, for: .touchUpInside)
        }
        searchCircle.contentView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTapSearch)
        ))
    }

    /// Expands a collapsed capsule or reports the tapped item.
    ///
    /// - Parameter itemView: Item that was tapped.
    private func didTap(_ itemView: GlassTabItemView) {
        guard !isCollapsed else {
            setCollapsed(false, animated: true)
            return
        }
        guard let index = itemViews.firstIndex(of: itemView) else {
            return
        }
        delegate?.glassTabBar(self, didSelectItemAt: index)
    }

    @objc
    private func didTapSearch() {
        setCollapsed(false, animated: true)
        delegate?.glassTabBarDidSelectSearch(self)
    }

    /// Moves the selection pill behind the selected item, hiding it while search is selected.
    ///
    /// - Parameter animated: Whether the move springs into place.
    private func moveSelectionPill(animated: Bool) {
        let changes = {
            guard let frame = self.selectedItemFrame() else {
                self.selectionPill.alpha = 0
                return
            }
            self.selectionPill.alpha = 1
            self.selectionPill.frame = frame
            self.selectionPill.layer.cornerRadius = frame.height / 2
        }

        if animated {
            UIView.animate(springDuration: 0.4, bounce: 0.2, options: [.allowUserInteraction], animations: changes)
        } else {
            changes()
        }
    }

    /// Computes the pill frame from the slot of the selected item among the visible ones.
    ///
    /// - Returns: The frame inside the capsule, or nil when no capsule item is selected.
    private func selectedItemFrame() -> CGRect? {
        let visibleItems = itemViews.filter { !$0.isHidden }

        guard let index = selectedIndex,
              itemViews.indices.contains(index),
              let slot = visibleItems.firstIndex(of: itemViews[index]) else {
            return nil
        }
        let slotWidth = itemsStack.frame.width / CGFloat(visibleItems.count)
        let frame = CGRect(
            x: itemsStack.frame.minX + CGFloat(slot) * slotWidth,
            y: itemsStack.frame.minY,
            width: slotWidth,
            height: itemsStack.frame.height
        )

        return frame.insetBy(dx: 2, dy: 6)
    }

    /// Builds a blurred, bordered surface that stands in for glass below iOS 26.
    ///
    /// - Returns: The effect view.
    private static func makeSurface() -> UIVisualEffectView {
        let surface = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))

        surface.clipsToBounds = true
        surface.layer.borderWidth = 0.5
        surface.layer.borderColor = UIColor.separator.cgColor
        surface.translatesAutoresizingMaskIntoConstraints = false
        return surface
    }
}
