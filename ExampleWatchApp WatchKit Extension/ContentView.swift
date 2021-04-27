//
//  ContentView.swift
//  ExampleWatchApp WatchKit Extension
//
//  Created by Dario Carlomagno on 25/04/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 6.0, content: {
            Text("Hello, Gigi!")
            Text("Enjoy the LIBERAZIONE!")
            Button("Ehm, No.") {
                
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
