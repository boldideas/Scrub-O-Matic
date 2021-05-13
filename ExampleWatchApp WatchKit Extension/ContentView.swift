//
//  ContentView.swift
//  ExampleWatchApp WatchKit Extension
//
//  Created by Dario Carlomagno on 25/04/21.
//

import SwiftUI
import Combine
import CountdownRing

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
    
    @State var isTimerRunning = false
    @ObservedObject var countdownTimer = CountdownTimer(limitTimeInteraval: 120)
    @State var timeRemaining = 120
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            
            ZStack {
                CountdownRingView(
                    countdownTimer: countdownTimer,
                    gradientColors: [.green, .blue],
                    lineWidth: 8
                )
                .padding(.bottom, 0.0)

                TimerTextView(countdownTimer: self.countdownTimer)
            }

            if isTimerRunning {
                Button("Reset") {
                    isTimerRunning = false
                    countdownTimer.reset()
                    WKInterfaceDevice.current().play(.retry)
                }
            } else {
                Button("Start") {
                    isTimerRunning = true
                    countdownTimer.start()
                    WKInterfaceDevice.current().play(.start)
                }
            }
        }
        .onReceive(timer) { _ in
            guard isTimerRunning else {
                return
            }
            
            let notifications: [Int: WKHapticType] = [90: .notification,
                                                      60: .directionDown,
                                                      30: .directionUp]
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                if let hapticNotification = notifications.first(where: {$0.key == timeRemaining})?.value {
                    WKInterfaceDevice.current().play(hapticNotification)
                }
                
            } else {
                WKInterfaceDevice.current().play(.stop)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
