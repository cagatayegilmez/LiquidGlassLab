//
//  IOSReleaseCatalog.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 16.09.2026.
//

nonisolated public enum IOSReleaseCatalog {
    public static let releases: [IOSRelease] = [
        IOSRelease(name: "iOS 27", year: 2026),
        IOSRelease(name: "iOS 26", year: 2025),
        IOSRelease(name: "iOS 18", year: 2024),
        IOSRelease(name: "iOS 17", year: 2023),
        IOSRelease(name: "iOS 16", year: 2022),
        IOSRelease(name: "iOS 15", year: 2021),
        IOSRelease(name: "iOS 14", year: 2020),
        IOSRelease(name: "iOS 13", year: 2019),
        IOSRelease(name: "iOS 12", year: 2018),
        IOSRelease(name: "iOS 11", year: 2017),
        IOSRelease(name: "iOS 10", year: 2016),
        IOSRelease(name: "iOS 9", year: 2015),
        IOSRelease(name: "iOS 8", year: 2014),
        IOSRelease(name: "iOS 7", year: 2013),
        IOSRelease(name: "iOS 6", year: 2012),
        IOSRelease(name: "iOS 5", year: 2011),
        IOSRelease(name: "iOS 4", year: 2010),
        IOSRelease(name: "iPhone OS 3", year: 2009),
        IOSRelease(name: "iPhone OS 2", year: 2008),
        IOSRelease(name: "iPhone OS 1", year: 2007)
    ]

    /// Filters the catalog by a case insensitive substring of the release name.
    ///
    /// - Parameter query: Text typed into a search field; blank returns everything.
    /// - Returns: Releases whose name contains the query.
    public static func releases(matching query: String) -> [IOSRelease] {
        let needle = query.trimmingCharacters(in: .whitespaces)

        guard !needle.isEmpty else {
            return releases
        }
        return releases.filter { $0.name.localizedCaseInsensitiveContains(needle) }
    }
}
