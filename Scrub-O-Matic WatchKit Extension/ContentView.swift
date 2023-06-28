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
            Text("Well done!")
                .font(.title)
                .bold()
            Text("🪥🎉")
                .font(.title)
            Button("Close") {

            }
        }
    }
}

struct Brushing: View {
    
    @State var isTimerRunning = false
    @ObservedObject var countdownTimer = CountdownTimer(limitTimeInteraval: Self.interval)
    @State var timeRemaining = Self.interval.asInt()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private static let interval: TimeInterval = 120

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
                        
            if timeRemaining > 0 {
                timeRemaining -= 1
                BrushingFeedback.sendTimerElapsingFeebackForInterval(Self.interval, elapsingTime: timeRemaining)
            } else {
                toggleTimer()
                BrushingFeedback.sendTimeElapsedFeedback()
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
