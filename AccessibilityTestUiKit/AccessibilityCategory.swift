//
//  AccessibilityCategory.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit

enum AccessibilityCategory: String, CaseIterable, Hashable {
    case vision
    case hearing
    case motor
    case motion

    var icon: String {
        switch self {
        case .vision: return "eye.fill"
        case .hearing: return "ear.fill"
        case .motor: return "hand.raised.fill"
        case .motion: return "figure.run"
        }
    }

    var color: UIColor {
        switch self {
        case .vision: return .systemBlue
        case .hearing: return .systemGreen
        case .motor: return .systemOrange
        case .motion: return .systemPurple
        }
    }

    var displayName: String {
        switch self {
        case .vision: return "Vision"
        case .hearing: return "Hearing"
        case .motor: return "Motor"
        case .motion: return "Motion"
        }
    }
}
