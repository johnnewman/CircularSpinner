//
//  CircularSpinner.swift
//  CircularSpinner
//
//  Created by John Newman on 3/25/24.
//

import SwiftUI
import Combine

public struct CircularSpinner<Background: ShapeStyle, Foreground: ShapeStyle>: View {
    
    let lineWidth: CGFloat
        
    let backgroundStyle: Background
    
    let foregroundStyle: Foreground
    
    let spinAnimation: Animation
    
    /// This timer will fire each time the spin animation finishes.
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    /// This accumulates the ongoing angle to keep the spinner moving.
    @State private var previousAngle: Angle = .zero
    
    /// This is toggled between values to oscillate the foreground circle's length.
    @State private var trimLength: Length = .short
    
    public init(lineWidth: CGFloat = 10,
                animationDuration: TimeInterval = 1.75,
                backgroundStyle: Background = Color.secondary,
                foregroundStyle: Foreground = Color.primary) {
        self.lineWidth = lineWidth
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
                    lineWidth: lineWidth,
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
            
            // Animated forground.
            circle(style: foregroundStyle, length: trimLength.value)
                .rotationEffect(currentAngle)
                .animation(spinAnimation, value: previousAngle)
                .onAppear(perform: cycleAnimation)
                .onReceive(timer) { _ in
                    cycleAnimation()
                }
        }
        .padding(lineWidth / 2)
    }
}

#Preview {
    VStack {
        CircularSpinner(
            lineWidth: 10,
            animationDuration: 2,
            backgroundStyle: .black,
            foregroundStyle: .thickMaterial.shadow(.inner(radius: 3))
        )
        
        CircularSpinner(
            lineWidth: 10,
            animationDuration: 1.75,
            backgroundStyle: Color.secondary,
            foregroundStyle: Color.primary
        )
        
        CircularSpinner(
            lineWidth: 10,
            animationDuration: 1.5,
            backgroundStyle: Color.black,
            foregroundStyle: LinearGradient(
                colors: [.purple, .red],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        
        CircularSpinner(
            lineWidth: 10,
            animationDuration: 1.25,
            backgroundStyle: .radialGradient(
                colors: [.green, .red],
                center: .center,
                startRadius: 25-10,
                endRadius: 25
            ),
            foregroundStyle: .cyan.shadow(.drop(radius: 2))
        )
    }
    .frame(width: 50)
}
