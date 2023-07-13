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
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    private static let interval: TimeInterval = 10

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
                BrushingFeedback.sendTimeElapsingForInterval(Self.interval, elapsingTime: timeRemaining)
            } else {
                BrushingFeedback.sendTimeElapsed()
            }
        }
    }
}

extension Brushing {
    private func startCountdownTimer() {
        countdownTimer.start()
    }
    
    private func resetCountdownTimer() {
        timeRemaining = Self.interval.asInt()
        countdownTimer.reset()
    }
}

extension Brushing {
    
    private func toggleTimer() {
        if isTimerRunning {
            resetCountdownTimer()
            WatchKitSession.shared.stop()
            BrushingFeedback.sendStart()
        } else {
            startCountdownTimer()
            WatchKitSession.shared.start()
            BrushingFeedback.sendStop()
        }
        isTimerRunning = !isTimerRunning
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
