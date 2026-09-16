//
//  LaunchOptions.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 15.09.2026.
//

nonisolated public struct LaunchOptions: Equatable, Sendable {

    public let showcase: ShowcaseKind?
    public let screen: DemoScreen?
    public let opensAntiPattern: Bool

    public var initialScreen: DemoScreen? {
        opensAntiPattern ? .labAntiPattern : screen
    }

    public init(showcase: ShowcaseKind? = nil,
                screen: DemoScreen? = nil,
                opensAntiPattern: Bool = false) {
        self.showcase = showcase
        self.screen = screen
        self.opensAntiPattern = opensAntiPattern
    }

    /// Reads the demo options out of process launch arguments such as `-DemoShowcase swiftui`.
    ///
    /// - Parameter arguments: Raw launch arguments, usually `CommandLine.arguments`.
    public init(arguments: [String]) {
        let values = Self.pairs(in: arguments)

        self.init(
            showcase: values[Key.showcase].flatMap(ShowcaseKind.init(rawValue:)),
            screen: values[Key.screen].flatMap(DemoScreen.init(rawValue:)),
            opensAntiPattern: values[Key.antiPattern].map(Self.isAffirmative) ?? false
        )
    }

    private enum Key {
        static let showcase = "DemoShowcase"
        static let screen = "DemoScreen"
        static let antiPattern = "DemoAntiPattern"
    }

    /// Collects `-Name value` argument pairs into a dictionary keyed by name without the dash.
    ///
    /// - Parameter arguments: Raw launch arguments.
    /// - Returns: Argument names mapped to the token that follows them.
    private static func pairs(in arguments: [String]) -> [String: String] {
        var pairs: [String: String] = [:]
        var index = arguments.startIndex

        while index < arguments.endIndex {
            let token = arguments[index]
            let next = arguments.index(after: index)

            if token.hasPrefix("-"), next < arguments.endIndex {
                pairs[String(token.dropFirst())] = arguments[next]
                index = arguments.index(after: next)
            } else {
                index = next
            }
        }
        return pairs
    }

    /// Interprets the usual truthy spellings of a launch argument value.
    ///
    /// - Parameter value: Raw argument value.
    /// - Returns: `true` for YES, TRUE or 1 regardless of case.
    private static func isAffirmative(_ value: String) -> Bool {
        ["yes", "true", "1"].contains(value.lowercased())
    }
}
