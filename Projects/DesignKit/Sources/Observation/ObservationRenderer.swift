//
//  ObservationRenderer.swift
//  LiquidGlassLab
//
//  Created by Çağatay Eğilmez on 14.09.2026.
//

import Observation

public enum ObservationRenderer {

    /// Runs the body now and again after every change of the observable state it reads.
    ///
    /// - Parameters:
    ///   - owner: Object whose lifetime bounds the rendering; it stops once the owner is released.
    ///   - body: Reads observable state and pushes it into the owner.
    public static func render<Owner: AnyObject & Sendable>(
        for owner: Owner,
        _ body: @escaping @Sendable @MainActor (Owner) -> Void
    ) {
        withObservationTracking {
            body(owner)
        } onChange: { [weak owner] in
            Task { @MainActor in
                guard let owner else {
                    return
                }
                render(for: owner, body)
            }
        }
    }
}
