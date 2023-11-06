//
//  ContentView.swift
//  Dog
//
//  Created by fernando babonoyaba on 9/10/23.
//

import SwiftUI
import MediaPlayer


struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    
    var body: some View {
        ZStack {
            Color.black
            LandscapeView()

        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
