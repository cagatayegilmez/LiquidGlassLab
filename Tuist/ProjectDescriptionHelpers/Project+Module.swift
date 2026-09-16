//
//  Project+Module.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import ProjectDescription

public extension Project {

    /// Builds a framework project with an optional example app.
    ///
    /// - Parameters:
    ///   - feature: Module the project describes.
    ///   - dependencies: Other modules the framework links against.
    ///   - includesExampleApp: Whether a standalone example app target is generated.
    /// - Returns: The project for the module.
    static func framework(
        _ feature: Feature,
        dependencies: [TargetDependency] = [],
        includesExampleApp: Bool = false
    ) -> Project {
        var targets: [Target] = [.framework(feature, dependencies: dependencies)]
        if includesExampleApp {
            targets.append(.exampleApp(for: feature))
        }
        return Project(
            name: feature.name,
            organizationName: BuildConstants.organizationName,
            settings: .shared,
            targets: targets
        )
    }
}

public extension Target {

    /// Builds the dynamic framework target of a module.
    ///
    /// - Parameters:
    ///   - feature: Module the framework belongs to.
    ///   - dependencies: Other modules the framework links against.
    /// - Returns: The framework target.
    static func framework(_ feature: Feature, dependencies: [TargetDependency]) -> Target {
        .target(
            name: feature.name,
            destinations: BuildConstants.destinations,
            product: .framework,
            bundleId: feature.bundleId,
            deploymentTargets: BuildConstants.deploymentTargets,
            sources: ["Sources/**"],
            dependencies: dependencies
        )
    }

    /// Builds the example app that runs a module on its own.
    ///
    /// - Parameter feature: Module the example app showcases.
    /// - Returns: The example app target.
    static func exampleApp(for feature: Feature) -> Target {
        .app(
            name: "\(feature.name)Example",
            bundleId: "\(feature.bundleId).example",
            sources: ["Example/Sources/**"],
            dependencies: [.target(name: feature.name)]
        )
    }

    /// Builds a scene based iOS app target.
    ///
    /// - Parameters:
    ///   - name: Target and product name.
    ///   - bundleId: Bundle identifier of the app.
    ///   - sources: Source file globs of the app.
    ///   - dependencies: Modules the app links against.
    ///   - settings: Build settings of the target.
    /// - Returns: The app target.
    static func app(
        name: String,
        bundleId: String,
        sources: SourceFilesList,
        dependencies: [TargetDependency],
        settings: Settings? = nil
    ) -> Target {
        .target(
            name: name,
            destinations: BuildConstants.destinations,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: BuildConstants.deploymentTargets,
            infoPlist: .sceneBasedApp,
            sources: sources,
            dependencies: dependencies,
            settings: settings
        )
    }
}

public extension InfoPlist {
    static let sceneBasedApp: InfoPlist = .dictionary([
        "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleInfoDictionaryVersion": "6.0",
        "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundlePackageType": "APPL",
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "LSRequiresIPhoneOS": true,
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false
        ],
        "UILaunchScreen": [:],
        "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationLandscapeLeft",
            "UIInterfaceOrientationLandscapeRight"
        ],
        "UISupportedInterfaceOrientations~ipad": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationPortraitUpsideDown",
            "UIInterfaceOrientationLandscapeLeft",
            "UIInterfaceOrientationLandscapeRight"
        ]
    ])
}
