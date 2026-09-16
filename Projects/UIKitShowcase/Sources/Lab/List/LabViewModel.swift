//
//  LabViewModel.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import DesignKit

final class LabViewModel: LabViewModelProtocol {
    let title = "Lab"
    let screens = DemoScreen.labScreens

    private let router: any LabRoutingProtocol

    init(router: any LabRoutingProtocol) {
        self.router = router
    }

    func select(_ screen: DemoScreen) {
        router.showLabScreen(screen)
    }
}
