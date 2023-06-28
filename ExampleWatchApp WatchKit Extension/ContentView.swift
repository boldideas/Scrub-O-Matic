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
    
    @State var isTimerRunning = false
    @ObservedObject var countdownTimer = CountdownTimer(limitTimeInteraval: 120)
    @State var timeRemaining = 120
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            CountdownRingView(
                countdownTimer: countdownTimer,
                gradientColors: [.green, .blue],
                padding: 10,
                lineWidth: 15
            )
            Text("\(isTimerRunning ? "STOP" : "START")")
                .font(.title)
        }
        .onTapGesture {
            toggleTimer()
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

extension Brushing {
    
    private func toggleTimer() {
        if isTimerRunning {
            countdownTimer.reset()
            WKInterfaceDevice.current().play(.retry)
        } else {
            countdownTimer.start()
            WKInterfaceDevice.current().play(.start)
        }
        isTimerRunning = !isTimerRunning
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
