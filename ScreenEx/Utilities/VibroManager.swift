//
//  VibroManager.swift
//  ScreenEx
//
//  Created by Ростислав on 17.12.2025.
//

import Foundation
import SwiftUI

class VibroManager {
    
    static private var generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
