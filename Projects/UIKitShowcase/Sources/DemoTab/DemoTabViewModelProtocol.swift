//
//  DemoTabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit
import UIKit

protocol DemoTabViewModelProtocol: AnyObject {
    var title: String { get }
    var headline: String { get }
    var backgroundColor: UIColor { get }
    var isSearchable: Bool { get }
    var releases: [IOSRelease] { get }

    /// Narrows the visible releases down to the ones matching the query.
    ///
    /// - Parameter query: Text typed into the search bar; blank restores the full list.
    func search(_ query: String)
}
