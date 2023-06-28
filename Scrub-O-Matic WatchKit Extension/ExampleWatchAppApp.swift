//
//  Copyright © 2023 Bold Ideas. All rights reserved.
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
