//
//  CircularSpinner.swift
//  CircularSpinner
//
//  Created by John Newman on 3/25/24.
//  Copyright (c) 2024 John Newman
//

import SwiftUI
import Combine

/// A View that will infinitely animate a circle with a foreground puck that spins.
public struct CircularSpinner<Background: ShapeStyle, Foreground: ShapeStyle>: View {
    
    let strokeWidth: CGFloat
    
    let diameter: CGFloat?
        
    let backgroundStyle: Background
    
    let foregroundStyle: Foreground
    
    let spinAnimation: Animation
    
    /// This timer will fire each time the spin animation finishes.
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    /// This accumulates the ongoing angle to keep the spinner moving.
    @State private var previousAngle: Angle = .zero
    
    /// This is toggled between values to oscillate the foreground puck's length.
    @State private var trimLength: Length = .short
    
    /// Initializes an indefinitely animating CircularSpinner.
    /// - Parameters:
    ///   - strokeWidth: The stroke width to use for the spinner background and
    ///   foreground circles.
    ///   - animationDuration: The duration of one spin cycle, which rotates the
    ///   puck 2 full revolutions around the circle.
    ///   - diameter: The diameter of the spinner. When nil, the spinner fills the
    ///   container's bounds.
    ///   - backgroundStyle: The ShapeStyle to apply to the full background circle.
    ///   - foregroundStyle: The ShapeStyle to apply to the spinning puck.
    public init(strokeWidth: CGFloat = 10,
                animationDuration: TimeInterval = 1.75,
                diameter: CGFloat? = nil,
                backgroundStyle: Background = Color.secondary,
                foregroundStyle: Foreground = Color.primary) {
        self.strokeWidth = strokeWidth
        self.diameter = diameter
        self.backgroundStyle = backgroundStyle
        self.foregroundStyle = foregroundStyle
        self.spinAnimation = .interpolatingSpring(duration: animationDuration)
        self.timer = Timer.publish(every: animationDuration, on: .main, in: .default).autoconnect()
    }
    
    var currentAngle: Angle {
        previousAngle + .degrees(720) + .degrees(-(360 * trimLength.value) / 2)
    }
    
    func circle<T: ShapeStyle>(style: T, length: CGFloat) -> some View {
        Circle()
            .trim(from: 0, to: length)
            .stroke(
                style: StrokeStyle(
                    lineWidth: strokeWidth,
                    lineCap: .round
                )
            )
            .foregroundStyle(style)
            // Start drawing the trim at the top center.
            .rotationEffect(.degrees(-90))
    }
    
    /// This is called every `animationDuration` to rotate the foreground and
    /// oscillate its length.
    func cycleAnimation() {
        previousAngle += .degrees(720)
        trimLength.toggle()
    }
        
    public var body: some View {
        ZStack {
            // Background circle.
            circle(style: backgroundStyle, length: 1)
            
            // Animated forground circle/puck.
            circle(style: foregroundStyle, length: trimLength.value)
                .rotationEffect(currentAngle)
                .animation(spinAnimation, value: previousAngle)
                .onAppear(perform: cycleAnimation)
                .onReceive(timer) { _ in
                    cycleAnimation()
                }
        }
        .padding(strokeWidth / 2)
        .conditionalWidth(diameter)
    }
}

#Preview("Diameter") {
    let diameter: CGFloat = 60
    return HStack {
        CircularSpinner(
            animationDuration: 2,
            diameter: diameter,
            style: .bubbledForeground
        )
        
        CircularSpinner(
            animationDuration: 1.75,
            diameter: diameter,
            style: .hierarchy
        )
        
        CircularSpinner(
            animationDuration: 1.5,
            diameter: diameter,
            style: .accent
        )
        
        CircularSpinner(
            animationDuration: 1.25,
            diameter: diameter,
            style: .nineties
        )
        
        CircularSpinner(
            animationDuration: 1,
            diameter: diameter,
            backgroundStyle: .white.shadow(.inner(radius: 3)),
            foregroundStyle: .red.shadow(.inner(radius: 3))
        )
    }
}

#Preview("ContainerSize") {
    HStack(spacing: 16) {
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 2,
            style: .bubbledForeground
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1.75,
            style: .hierarchy
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1.5,
            style: .accent
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1.25,
            style: .nineties
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1,
            backgroundStyle: .white.shadow(.inner(radius: 3)),
            foregroundStyle: .red.shadow(.inner(radius: 3))
        )
    }
    .frame(height: 90)
}
