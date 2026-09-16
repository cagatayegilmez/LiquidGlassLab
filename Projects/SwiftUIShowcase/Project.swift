//
//  Project.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    .swiftUIShowcase,
    dependencies: [Feature.designKit.dependency],
    includesExampleApp: true
)
