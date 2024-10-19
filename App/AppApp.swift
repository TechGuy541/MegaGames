//
//  AppApp.swift
//  App
//
//  Created by Tech Guy on 10/7/24.
//

import SwiftUI

@main
struct AppApp: App {
    // Integrate AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}



