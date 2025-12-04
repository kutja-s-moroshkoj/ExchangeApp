//
//  ScreenExApp.swift
//  ScreenEx
//
//  Created by Ростислав on 02.12.2025.
//

import SwiftUI

@main
struct ScreenExApp: App {
    
    @StateObject private var viewModel = BaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                BaseScreen()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)
        }
    }
}
