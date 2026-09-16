//
//  LabViewModelProtocol.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit

protocol LabViewModelProtocol: AnyObject {
    var title: String { get }
    var screens: [DemoScreen] { get }

    /// Opens the lab screen picked from the list.
    ///
    /// - Parameter screen: Lab screen to open.
    func select(_ screen: DemoScreen)
}
