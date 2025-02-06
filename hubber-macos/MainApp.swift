//
//  hubber_macosApp.swift
//  hubber-macos
//
//  Created by Cosmin Cosan - work on 04.02.2025.
//

import SwiftUI

@main
struct MainApp: App {
    
    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
        } label: {
            menuBarLabel
        }
        .menuBarExtraStyle(.window)
    }
}

//MARK: - view components
extension MainApp {
    private var menuBarLabel: some View {
        Label("hubber", systemImage: "message.badge.filled.fill")
            .symbolRenderingMode(.palette)
            .foregroundColor(.indigo)
    }
}
