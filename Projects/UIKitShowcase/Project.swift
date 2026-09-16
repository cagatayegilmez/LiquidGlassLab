//
//  Project.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    .uiKitShowcase,
    dependencies: [Feature.designKit.dependency],
    includesExampleApp: true
)
