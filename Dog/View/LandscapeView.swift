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
    var old: some View {
        GeometryReader { screen in
            
            HStack {
                HStack {
                    SoundButton(soundController: soundController,
                                size: screen.size.height)
                    .animation(.spring(), value: screen.size)
                }
                .frame(height: screen.size.width / 2)
                Spacer()

                VStack {
                    Spacer()

                    Button {
                        soundController.toggleContinuous()
                    } label: {
                        Text("Continuous")
                    }
                    .font(.title)
                    .padding(10)
                    .foregroundColor(soundController.soundModel.isSelected ? .black : .white)
                    .background(soundController.continuousButtonColor)
                    .cornerRadius(50)
                    
                    Spacer()
                    
                    Slider(value: $soundController.soundModel.hertz, in: 1...200)
                        .tint(.green)
                    
                    Spacer()
                    
                    
                    Text("\(Int(soundController.soundModel.hertz) * 100) Hz")
                        .font(.title)
                    Spacer()
                }
                .frame(width: screen.size.width / 2)


                
            }
            .padding(.vertical)
            
        }
    }
    
}

#Preview {
    LandscapeView()
}
