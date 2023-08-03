//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import SwiftUI

struct Landing: View {
    
    @Binding var screen: ContentView.Screen
    @ObservedObject var brushingFeedbackService: BrushingFeedbackService

    private var wellDoneView: some View {
        VStack(alignment: .center, spacing: 6.0) {
            Text("Well done!")
                .font(.title)
                .bold()
            Text("🪥🎉")
                .font(.title)
            Button("Done") {
                screen = .brushing
                brushingFeedbackService.sendStop()
            }
        }
    }
    
    var body: some View {
        ZStack {
            wellDoneView
            EmojiBubbleView()
        }
    }
}
