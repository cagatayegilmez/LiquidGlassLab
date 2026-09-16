//
//  DemoTabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import Observation
import UIKit

@Observable
final class DemoTabViewModel: DemoTabViewModelProtocol {
    let title: String
    let headline: String
    let backgroundColor: UIColor
    let isSearchable: Bool
    private(set) var releases: [IOSRelease]

    init(screen: DemoScreen) {
        self.title = screen.title
        self.headline = screen.headline
        self.backgroundColor = screen.backgroundColor
        self.isSearchable = screen == .search
        self.releases = IOSReleaseCatalog.releases
    }

    func search(_ query: String) {
        releases = IOSReleaseCatalog.releases(matching: query)
    }
}
