//
//  Length.swift
//  CircularSpinner
//
//  Created by John Newman on 3/25/24.
//  Copyright (c) 2024 John Newman
//

import Foundation

/// This model is used to represent the current foreground trim length.
enum Length {
    
    case long, short
    
    var value: CGFloat {
        switch self {
        case .long: return 0.85
        case .short: return 0.1
        }
    }
    
    mutating func toggle() {
        switch self {
        case .long: self = .short
        case .short: self = .long
        }
    }
}

