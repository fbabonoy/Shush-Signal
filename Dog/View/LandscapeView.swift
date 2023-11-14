//
//  LandscapeView.swift
//  Dog
//
//  Created by fernando babonoyaba on 10/24/23.
//

import SwiftUI

struct LandscapeView: View {
    @ObservedObject var soundController: SoundController = SoundController()
    
    let lansdcaper = true
        
    var body: some View {
        GeometryReader { screen in
            
            HStack {
                SoundButton(soundController: soundController,
                            size: screen.size.height)
                .frame(width: screen.size.width / 2)
                
                Spacer()
                
                SettingsView(soundController: soundController, width: screen.size.width)
                    .frame(width: screen.size.width / 2.5)


            }
            .padding(.vertical)
        }
    }
    
}

#Preview {
    LandscapeView()
}
