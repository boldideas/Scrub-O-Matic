//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import SwiftUI

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
                gradientColors: [.purple, .blue],
                padding: 10,
                lineWidth: 15
            )
            Text("\(isTimerRunning ? "Stop" : "Start\nBrushing")")
                .font(.title3)
                .multilineTextAlignment(.center)
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
