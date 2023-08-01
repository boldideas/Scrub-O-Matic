//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import SwiftUI

struct EmojiBubbleView: View {
    
    @State private var animate = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<150) { _ in
                    let offsetX = CGFloat.random(in: -geometry.size.width...geometry.size.width*2)
                    let initialOffsetY = CGFloat.random(in: geometry.size.height...geometry.size.height*4)
                    Text("🫧")
                        .font(.largeTitle)
                        .offset(x: offsetX, y: animate ? -geometry.size.height * 3 : initialOffsetY)
                }
            }
        }
        .onAppear {
            SoundPlayer.play("bubbles", withExtension: "m4a")
            withAnimation(.linear(duration: 10)) {
                animate = true
            }
        }
    }
}
