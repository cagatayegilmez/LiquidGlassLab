//
//  Settings+Shared.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

import ProjectDescription

public enum BuildConstants {
    public static let bundleIdRoot = "io.github.cagatayegilmez.liquidglasslab"
    public static let organizationName = "Çağatay Eğilmez"
    public static let deploymentTargets: DeploymentTargets = .iOS("18.0")
    public static let destinations: Destinations = [.iPhone, .iPad]
}

public extension SettingsDictionary {
    static let strictConcurrency: SettingsDictionary = [
        "SWIFT_VERSION": "6.0",
        "SWIFT_STRICT_CONCURRENCY": "complete",
        "SWIFT_DEFAULT_ACTOR_ISOLATION": "MainActor",
        "SWIFT_APPROACHABLE_CONCURRENCY": "YES",
        "SWIFT_TREAT_WARNINGS_AS_ERRORS": "YES"
    ]
}

public extension Settings {
    static let shared: Settings = .shared(extending: [:])

    /// Builds the shared build settings with extra target specific keys merged in.
    ///
    /// - Parameter extra: Settings that override or extend the shared base.
    /// - Returns: Settings ready to attach to a project or target.
    static func shared(extending extra: SettingsDictionary) -> Settings {
        .settings(base: SettingsDictionary.strictConcurrency.merging(extra) { _, new in new })
    }
}
