//
//  SpinAnimation.swift
//  CircularSpinner
//
//  Created by John Newman on 3/25/24.
//

import Foundation
import SwiftUI

enum SpinAnimation {
    case long(duration: TimeInterval), short(duration: TimeInterval)
    
    var value: Animation {
        switch self {
        case .long(let duration): return .interpolatingSpring(duration: duration, bounce: 0.06)
        case .short(let duration): return .interpolatingSpring(duration: duration, bounce: 0)
        }
    }
    
    mutating func toggle() {
        switch self {
        case .long(let duration): self = .short(duration: duration)
        case .short(let duration): self = .long(duration: duration)
        }
    }
}

