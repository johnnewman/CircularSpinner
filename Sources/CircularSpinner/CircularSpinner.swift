//
//  CircularSpinner.swift
//  CircularSpinner
//
//  Created by John Newman on 3/25/24.
//  Copyright (c) 2024 John Newman
//

import SwiftUI
import Combine

/// A View that will infinitely animate a circle with a foreground that spins.
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
    
    /// This is toggled between values to oscillate the foreground circle's length.
    @State private var trimLength: Length = .short
    
    /// Initializes the CircularSpinner, which will begin animating as soon as
    /// it appears.
    /// - Parameters:
    ///   - lineWidth: The stroke width to use for the circle.
    ///   - animationDuration: The duration of a spin cycle that rotates 2 revolutions.
    ///   - radius: The radius of the spinner.
    ///   - backgroundStyle: The ShapeStyle to apply to the full background circle.
    ///   - foregroundStyle: The ShapeStyle to apply to the spinning circle.
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
            .rotationEffect(.degrees(-90))
    }
    
    func cycleAnimation() {
        previousAngle += .degrees(720)
        trimLength.toggle()
    }
    
    public var body: some View {
        ZStack {
            // Background circle.
            circle(style: backgroundStyle, length: 1)
            
            // Animated forground circle.
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

extension View {
    @ViewBuilder func conditionalWidth(_ width: CGFloat?) -> some View {
        if let width = width {
            self.frame(width: width)
        } else {
            self
        }
    }
}

#Preview("Diameter") {
    VStack {
        CircularSpinner(
            animationDuration: 2,
            diameter: 60,
            backgroundStyle: .black,
            foregroundStyle: .thickMaterial.shadow(.inner(radius: 3))
        )
        
        CircularSpinner(
            animationDuration: 1.75,
            diameter: 60,
            backgroundStyle: Color.secondary,
            foregroundStyle: Color.primary
        )
        
        CircularSpinner(
            animationDuration: 1.5,
            diameter: 60,
            backgroundStyle: Color.teal,
            foregroundStyle: LinearGradient(
                colors: [.purple, .red],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        
        CircularSpinner(
            animationDuration: 1.25,
            diameter: 60,
            backgroundStyle: .radialGradient(
                colors: [.green, .red],
                center: .center,
                startRadius: 30-10,
                endRadius: 30
            ),
            foregroundStyle: .cyan.shadow(.drop(radius: 2))
        )
    }
}

#Preview("ContainerSize") {
    VStack {
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 2,
            backgroundStyle: .black,
            foregroundStyle: .thickMaterial.shadow(.inner(radius: 3))
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1.75,
            backgroundStyle: Color.secondary,
            foregroundStyle: Color.primary
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1.5,
            backgroundStyle: Color.teal,
            foregroundStyle: LinearGradient(
                colors: [.purple, .red],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        
        CircularSpinner(
            strokeWidth: 15,
            animationDuration: 1.25,
            backgroundStyle: .radialGradient(
                colors: [.green, .red],
                center: .center,
                startRadius: 45-15,
                endRadius: 45
            ),
            foregroundStyle: .cyan.shadow(.drop(radius: 2))
        )
    }
    .frame(width: 90)
}
