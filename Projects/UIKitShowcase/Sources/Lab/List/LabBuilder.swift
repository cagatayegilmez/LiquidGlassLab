//
//  LabBuilder.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import DesignKit
import UIKit

enum LabBuilder {

    /// Assembles the lab list scene with its router.
    ///
    /// - Parameter environment: Environment carrying the showcase switch callback.
    /// - Returns: The view controller of the scene.
    static func build(environment: ShowcaseEnvironment) -> UIViewController {
        let router = LabRouter()
        let viewModel = LabViewModel(router: router)
        let controller = LabViewController(viewModel: viewModel, environment: environment)

        router.source = controller
        return controller
    }
}
