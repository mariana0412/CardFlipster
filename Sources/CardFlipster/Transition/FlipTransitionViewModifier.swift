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

    struct Axis3D {
        let axisX: CGFloat
        let axisY: CGFloat
        let axisZ: CGFloat
    }

    let isActive: Bool
    let side: Side
    let axis: Axis
    let perspective: CGFloat

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                Angle.degrees(side == .back ? 0 : 180),
                axis: (resolvedAxis.axisX, resolvedAxis.axisY, resolvedAxis.axisZ),
                perspective: 0
            )
            .rotation3DEffect(
                Angle.degrees(
                    isActive
                        ? (side == .back ? 180 : 0)
                        : (side == .back ? 0 : 180)
                ),
                axis: (resolvedAxis.axisX, resolvedAxis.axisY, resolvedAxis.axisZ),
                perspective: perspective
            )
    }

    private var resolvedAxis: Axis3D {
        switch axis {
        case .horizontal:
            return Axis3D(axisX: 0, axisY: 1, axisZ: 0)
        case .vertical:
            return Axis3D(axisX: 1, axisY: 0, axisZ: 0)
        }
    }

}
