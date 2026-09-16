//
//  LabRouter.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit
import UIKit

final class LabRouter: LabRoutingProtocol {
    weak var source: UIViewController?

    func showLabScreen(_ screen: DemoScreen) {
        guard let controller = LabScreenFactory.makeViewController(for: screen) else {
            return
        }
        source?.navigationController?.pushViewController(controller, animated: true)
    }
}
