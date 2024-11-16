//
//  FlipTransitionViewModifier.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

import SwiftUI

// Code snippet sourced from Stack Overflow
// https://stackoverflow.com/a/79162092
// Answer by Robert Dresler
struct FlipTransitionViewModifier: ViewModifier {

    public enum Side {
        case front
        case back
    }

    let isActive: Bool
    let side: Side
    let axis: Axis
    let perspective: CGFloat

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                Angle.degrees(side == .back ? 0 : 180),
                axis: resolvedAxis,
                perspective: 0
            )
            .rotation3DEffect(
                Angle.degrees(
                    isActive
                        ? (side == .back ? 180 : 0)
                        : (side == .back ? 0 : 180)
                ),
                axis: resolvedAxis,
                perspective: perspective
            )
    }

    private var resolvedAxis: (CGFloat, CGFloat, CGFloat) {
        switch axis {
        case .horizontal:
            (0, 1, 0)
        case .vertical:
            (1, 0, 0)
        }
    }

}
