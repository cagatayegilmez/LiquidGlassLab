//
//  LabRoutingProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import DesignKit

protocol LabRoutingProtocol: AnyObject {

    /// Pushes a lab screen onto the navigation stack.
    ///
    /// - Parameter screen: Lab screen to show.
    func showLabScreen(_ screen: DemoScreen)
}
