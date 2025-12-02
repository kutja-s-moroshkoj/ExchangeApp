//
//  ScreenExApp.swift
//  ScreenEx
//
//  Created by Ростислав on 02.12.2025.
//

import SwiftUI

@main
struct ScreenExApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                BaseScreen()
                    .toolbar(.hidden)
            }
        }
    }
}
