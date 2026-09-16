//
//  Feature.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import ProjectDescription

public enum Feature: String, CaseIterable {
    case designKit = "DesignKit"
    case swiftUIShowcase = "SwiftUIShowcase"
    case uiKitShowcase = "UIKitShowcase"

    public var name: String {
        rawValue
    }

    public var bundleId: String {
        "\(BuildConstants.bundleIdRoot).\(rawValue.lowercased())"
    }

    public var projectPath: Path {
        .relativeToRoot("Projects/\(rawValue)")
    }

    public var dependency: TargetDependency {
        .project(target: rawValue, path: projectPath)
    }
}
