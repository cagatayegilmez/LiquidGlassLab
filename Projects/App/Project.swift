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
            resources: ["Sources/AppIcon.icon"],
            dependencies: Feature.allCases.map(\.dependency),
            settings: .shared(extending: ["ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon"])
        )
    ]
)
