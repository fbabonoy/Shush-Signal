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
                VStack {
                    SoundButton(buttonAnimation: $soundController.soundModel.buttonAnimation,
                                continuous: $soundController.soundModel.isSelected,
                                size: screen.size.height,
                                volume: soundController.soundModel.volume,
                                hertz: soundController.soundModel.hertz,
                                unit: soundController.soundModel.sound)
                    .animation(.spring(), value: screen.size)
                }
                .frame(height: screen.size.width / 2)
                
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
                
            }
            .padding(.vertical)
            
        }
    }
    
}

#Preview {
    LandscapeView()
}
