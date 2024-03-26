//
//  CircularSpinner.swift
//  CircularSpinner
//
//  Created by John Newman on 3/25/24.
//

import SwiftUI
import Combine

struct CircularSpinner<Background: ShapeStyle, Foreground: ShapeStyle>: View {
    
    let lineWidth: CGFloat
    
    let animationDuration: TimeInterval
    
    let backgroundStyle: Background
    
    let foregroundStyle: Foreground
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    @State private var animate: Bool = false
        
    @State private var previousAngle: Angle = .zero
    
    @State private var trimLength: Length = .short
        
    @State private var animation: SpinAnimation
    
    init(lineWidth: CGFloat = 20,
         animationDuration: TimeInterval = 1.75,
         backgroundStyle: Background,
         foregroundStyle: Foreground) {
        self.lineWidth = lineWidth
        self.animationDuration = animationDuration
        self.backgroundStyle = backgroundStyle
        self.foregroundStyle = foregroundStyle
        self.timer = Timer.publish(every: animationDuration, on: .main, in: .default).autoconnect()
        self.animation = .short(duration: animationDuration)
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
    }
    
    var angle: Angle {
        previousAngle + .degrees(720) + .degrees(-90 - (360 * trimLength.value) / 2)
    }
    
    func cycleAnimation() {
        previousAngle += .degrees(720)
        trimLength.toggle()
    }
        
    var body: some View {
        ZStack {
            // Background circle.
            circle(style: backgroundStyle, length: 1)
            
            // Animated forground stroke.
            circle(style: foregroundStyle, length: trimLength.value)
                .rotationEffect(angle)
                .animation (
                    animation.value,
                    value: previousAngle
                )
                .onAppear(perform: cycleAnimation)
                .onReceive(timer) { _ in
                    cycleAnimation()
                }
        }
    }
}

#Preview {
    CircularSpinner(
        lineWidth: 10,
        backgroundStyle: Color.gray,
        foregroundStyle: Color.black
    )
    .frame(width: 50, height: 50)
    .padding()
}
