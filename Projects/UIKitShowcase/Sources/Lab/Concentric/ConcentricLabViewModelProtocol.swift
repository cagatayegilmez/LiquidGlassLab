//
//  ConcentricLabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import UIKit

protocol ConcentricLabViewModelProtocol: AnyObject {
    var title: String { get }
    var backgroundColor: UIColor { get }
    var inset: CGFloat { get }
    var fixedRadius: CGFloat { get }
    var containerRadius: CGFloat { get }
    var radiusText: String { get }

    /// Stores the slider value that drives the container corner radius.
    ///
    /// - Parameter radius: Radius in points.
    func updateRadius(_ radius: CGFloat)
}
