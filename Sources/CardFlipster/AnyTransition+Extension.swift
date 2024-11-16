//
//  AnyTransition+Extension.swift
//  CardFlipster
//
//  Created by Mariana Piz on 16.11.2024.
//

import SwiftUI

// Code snippet sourced from Stack Overflow
// https://stackoverflow.com/a/79162092
// Answer by Robert Dresler
extension AnyTransition {
    
    @MainActor static func flip(side: FlipTransitionViewModifier.Side,
                                axis: Axis = .horizontal,
                                perspective: CGFloat = 0,
                                animationDuration: TimeInterval = 0.25) -> AnyTransition {
        .modifier(
            active: FlipTransitionViewModifier(
                isActive: true,
                side: side,
                axis: axis,
                perspective: perspective
            ),
            identity: FlipTransitionViewModifier(
                isActive: false,
                side: side,
                axis: axis,
                perspective: perspective
            )
        )
        .combined(
            with: .opacity.animation(
                .linear(duration: 0.001).delay(animationDuration / 2)
            )
        )
        .animation(.linear(duration: animationDuration))
    }

}
