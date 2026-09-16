//
//  ConcentricLabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import Observation
import UIKit

@Observable
final class ConcentricLabViewModel: ConcentricLabViewModelProtocol {
    let title = DemoScreen.labConcentric.title
    let backgroundColor = DemoScreen.labConcentric.backgroundColor
    let inset: CGFloat = 16
    let fixedRadius: CGFloat = 12
    private(set) var containerRadius: CGFloat = 32

    var radiusText: String {
        "Container radius: \(Int(containerRadius))"
    }

    func updateRadius(_ radius: CGFloat) {
        containerRadius = radius.rounded()
    }
}
