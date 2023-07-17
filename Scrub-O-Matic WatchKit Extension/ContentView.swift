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

struct Landing: View {
    
    @Binding var screen: ContentView.Screen
    @ObservedObject var brushingFeedbackService: BrushingFeedbackService

    var body: some View {
        VStack(alignment: .center, spacing: 6.0) {
            Text("Well done!")
                .font(.title)
                .bold()
            Text("🪥🎉")
                .font(.title)
            Button("Close") {
                screen = .brushing
                brushingFeedbackService.sendStop()
            }
        }
    }
}

struct Brushing: View {
    
    @Binding var screen: ContentView.Screen
    @State var isTimerRunning = false
    @ObservedObject var countdownTimer = CountdownTimer(limitTimeInteraval: Self.interval)
    @ObservedObject var brushingFeedbackService: BrushingFeedbackService
    @State var timeRemaining = Self.interval.asInt()
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    private static let interval: TimeInterval = BrushingInterval.time

    var body: some View {
        ZStack {
            CountdownRingView(
                countdownTimer: countdownTimer,
                gradientColors: [.orange, .blue],
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
                BrushingFeedbackService.sendTimeElapsingForInterval(Self.interval, elapsingTime: timeRemaining)
            } else {
                brushingFeedbackService.sendTimeElapsed()
                navigateToLandingScreen()
            }
        }
    }
}

extension Brushing {
    
    func navigateToLandingScreen() {
        screen = .landing
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
            brushingFeedbackService.sendStop()
        } else {
            startCountdownTimer()
            brushingFeedbackService.sendStart()
        }
        isTimerRunning = !isTimerRunning
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
