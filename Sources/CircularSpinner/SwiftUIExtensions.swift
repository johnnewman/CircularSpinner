//
//  SwiftUIExtensions.swift
//  CircularSpinner
//
//  Created by John Newman on 4/8/24.
//  Copyright (c) 2024 John Newman
//

import Foundation
import SwiftUI

public extension View {
    
    /// If `width` is set, this returns a View with its width constrained to the
    /// supplied value.
    @ViewBuilder func conditionalWidth(_ width: CGFloat?) -> some View {
        if let width = width {
            self.frame(width: width)
        } else {
            self
        }
    }
}

public extension ShapeStyle {
    
    /// Returns `self` as the type-erased AnyShapeStyle.
    var anyShapeStyle: AnyShapeStyle {
        AnyShapeStyle(self)
    }
}
