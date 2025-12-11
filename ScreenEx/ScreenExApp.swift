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
    
    init () {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.appColor.accentAppcolor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.appColor.accentAppcolor)]
    }
    
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
