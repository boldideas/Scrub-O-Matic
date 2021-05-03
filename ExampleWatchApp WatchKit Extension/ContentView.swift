//
//  ContentView.swift
//  ExampleWatchApp WatchKit Extension
//
//  Created by Dario Carlomagno on 25/04/21.
//

import SwiftUI
import Combine
struct ContentView: View {
    
    enum Screen {
        case landing
        case brushing
    }

    @State var screen: Screen = .brushing
    
    var body: some View {
        VStack {
            switch screen {
            case .landing:
                Landing()
            case .brushing:
                Brushing()
            }
        }
    }
}

struct Landing: View {
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 6.0) {
            Text("Hello, Gigi!")
            Text("Enjoy the LIBERAZIONE!")
            Button("Ehm, No.") {
                
            }
        }
    }
    
}

struct Brushing: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    @State var isTimerRunning = false
    
    @State var timeRemaining = 120
        
    var body: some View {
        VStack {
            Text("\(timeRemaining/60):\(timeRemaining%60)")
                .font(.largeTitle)
            if isTimerRunning {
                Button("Pause") {
                    isTimerRunning = false
                }
            } else {
                Button("Start") {
                    isTimerRunning = true
                }
            }
        }
        .onReceive(timer) { _ in
            guard isTimerRunning else {
                return
            }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
}

//class Timer: ObservableObject {
//
//    @Published
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
