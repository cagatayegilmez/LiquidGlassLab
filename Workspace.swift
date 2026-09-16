//
//  Workspace.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "LiquidGlassLab",
    projects: [.relativeToRoot("Projects/App")] + Feature.allCases.map(\.projectPath)
)
