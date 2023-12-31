//
//  PortraitView.swift
//  Dog
//
//  Created by fernando babonoyaba on 10/24/23.
//

import SwiftUI

struct PortraitView: View {
    @ObservedObject var soundController: SoundController = SoundController()
    
    var isIpad: Bool {
        UIDevice.current.model == "iPad" ? true : false
    }

   
    var body: some View {
        GeometryReader { screen in
            
            VStack {
                SoundButton(soundController: soundController,
                            size: screen.size.width)
                .frame(height: isIpad ? screen.size.width : screen.size.height / 2)
                
                Spacer()
                
                SettingsView(soundController: soundController, width: screen.size.width)
                    .frame(width: screen.size.width)


            }
            .padding(.vertical)
        }
    }
    
}

#Preview {
    PortraitView()
}
