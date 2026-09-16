//
//  Project.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LiquidGlassLab",
    organizationName: BuildConstants.organizationName,
    settings: .shared,
    targets: [
        .app(
            name: "LiquidGlassLab",
            bundleId: BuildConstants.bundleIdRoot,
            sources: ["Sources/**"],
            dependencies: Feature.allCases.map(\.dependency)
        )
    ]
)
