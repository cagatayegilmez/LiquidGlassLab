//
//  Tuist.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

import ProjectDescription

let tuist = Tuist(
    project: .tuist(
        compatibleXcodeVersions: .upToNextMajor("27.0"),
        generationOptions: .options(defaultSwiftVersion: "6.0")
    )
)
