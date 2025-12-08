//
//  UiApplication.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
