//
//  ExampleWatchAppApp.swift
//  ExampleWatchApp WatchKit Extension
//
//  Created by Dario Carlomagno on 25/04/21.
//

import SwiftUI

@main
struct ExampleWatchAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
