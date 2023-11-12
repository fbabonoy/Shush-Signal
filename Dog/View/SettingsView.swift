//
//  SettingsView.swift
//  Dog
//
//  Created by fernando babonoyaba on 11/6/23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var soundController: SoundController = SoundController()
    var width: CGFloat


    var body: some View {
        VStack {
            Spacer()
            //TODO: i want to add two buttons that will increase or decrese the frequency by 100 Hz
            Text("\(Int(soundController.soundModel.hertz) * 100) Hz")
                .font(.title)
           
            
            Spacer()
            
            Slider(value: $soundController.soundModel.hertz, in: 1...200)
                .tint(.green)
            
            Spacer()
            
            Button {
                soundController.toggleContinuous()
            } label: {
                Text("Hold Sound Button")
            }
            .font(.title)
            .padding(10)
            .foregroundColor(soundController.soundModel.isSelected ? .black : .white)
            .background(soundController.continuousButtonColor)
            .cornerRadius(50)
            
            Spacer()
        }
    }
}

#Preview {
    GeometryReader { screen in
        SettingsView(soundController: SoundController(), width: screen.size.width)
        
    }}
