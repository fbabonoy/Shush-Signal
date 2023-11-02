//
//  PortraitView.swift
//  Dog
//
//  Created by fernando babonoyaba on 10/24/23.
//

import SwiftUI

struct PortraitView: View {
    @ObservedObject var soundController: SoundController = SoundController()
   
    var continuousButtonColor: Color {
        if soundController.soundModel.isSelected {
            return Color.green
        }
        
        return .init(red: 0.1, green: 0.1, blue: 0.1)
    }

    var body: some View {
        GeometryReader { screen in
            
            VStack{
                Spacer()
                VStack {
                    SoundButton(buttonAnimation: $soundController.soundModel.buttonAnimation, continuous: $soundController.soundModel.isSelected, size: screen.size.width, volume: soundController.soundModel.volume, hertz: soundController.soundModel.hertz, unit: soundController.soundModel.sound)
                        .animation(.spring(), value: screen.size)
                }
                .frame(height: screen.size.height / 1.5)
                Spacer()
                
                
                Button {
                    soundController.toggleContinuous()
                } label: {
                    Text("Continuous")
                }
                .font(.title)
                .padding(10)
                .foregroundColor(soundController.soundModel.isSelected ? .black : .white)
                .background(continuousButtonColor)
                .cornerRadius(50)
                
                Spacer()
                
                Slider(value: $soundController.soundModel.hertz, in: 1...200)
                    .tint(.green)
                
                Spacer()
                
                
                Text("\(Int(soundController.soundModel.hertz) * 100) Hz")
                    .font(.title)
                Spacer()
                
                
            }
            .padding(.vertical)
        }
    }
    
    
}

#Preview {
    PortraitView()
}
