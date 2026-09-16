//
//  IOSRelease.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

nonisolated public struct IOSRelease: Identifiable, Hashable, Sendable {
    public let name: String
    public let year: Int

    public var id: String {
        name
    }

    public init(name: String, year: Int) {
        self.name = name
        self.year = year
    }
}
