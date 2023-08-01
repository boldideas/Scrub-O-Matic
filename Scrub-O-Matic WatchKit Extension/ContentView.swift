//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//
import SwiftUI
import Combine

struct ContentView: View {
    
    enum Screen {
        case landing
        case brushing
    }
    
    @State var screen: Screen = .brushing
    @StateObject var brushingFeedbackService = BrushingFeedbackService()
        
    var body: some View {
        VStack {
            switch screen {
            case .landing:
                Landing(screen: $screen,
                        brushingFeedbackService: brushingFeedbackService)
            case .brushing:
                Brushing(screen: $screen,
                         brushingFeedbackService: brushingFeedbackService)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
