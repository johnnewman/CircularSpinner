//
//  CiricularSpinnerExtensions.swift
//  CircularSpinner
//
//
//  Created by John Newman on 4/8/24.
//  Copyright (c) 2024 John Newman
//

import Foundation
import SwiftUI

/// A model for pre-styled spinners.
public enum SpinnerStyle {
    
    case bubbledForeground
    case hierarchy
    case accent
    case nineties
    
    var background: AnyShapeStyle {
        switch self {
        case .bubbledForeground:
            return Color.black.anyShapeStyle
        case .hierarchy:
            return Color.secondary.anyShapeStyle
        case .accent:
            return Color(uiColor: .systemGray3).anyShapeStyle
        case .nineties:
            return Color.teal.anyShapeStyle
        }
    }
    
    var foreground: AnyShapeStyle {
        switch self {
        case .bubbledForeground:
            return Color(white: 0.94)
                .shadow(.inner(radius: 3))
                .anyShapeStyle
        case .hierarchy:
            return Color.primary.anyShapeStyle
        case .accent:
            return Color.accentColor.anyShapeStyle
        case .nineties:
            return LinearGradient(
                colors: [.purple, .red],
                startPoint: .leading,
                endPoint: .trailing
            ).anyShapeStyle
        }
    }
}

public extension CircularSpinner where Foreground == AnyShapeStyle, Background == AnyShapeStyle {
    
    /// Convenience to initialize the CircularSpinner with a provided SpinnerStyle.
    init(strokeWidth: CGFloat = 10,
         animationDuration: TimeInterval = 1.75,
         diameter: CGFloat? = nil,
         style: SpinnerStyle) {
        
        self.init(
            strokeWidth: strokeWidth,
            animationDuration: animationDuration,
            diameter: diameter,
            backgroundStyle: style.background,
            foregroundStyle: style.foreground
        )
    }

}
