//
//  Button.swift
//  Dog
//
//  Created by fernando babonoyaba on 9/11/23.
//

import SwiftUI
import AVFoundation

struct SoundButton: View {
    @ObservedObject var soundController: SoundController = SoundController()

    var size: CGFloat

    private var unit: ToneV2 {
        soundController.soundModel.sound
    }
    
    private var colorPicker: Color {
        soundController.soundModel.buttonAnimation == true ? .green : .init(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    private var width: Double {
        colorPicker == .green ? size * 0.95 : size
    }
    
    var body: some View {
        VStack {
            Button {
                
                if !soundController.soundModel.buttonAnimation && soundController.soundModel.isSelected {
                    startTone()
                } else {
                    stopTone()
                }
                
            } label: {
                ZStack {
                    Color.init(red: 0.0, green: 0.5, blue: 0.0)
                        .frame(width: size * 0.99, height:  size * 0.99)
                        .cornerRadius(size * 0.1)
                    
                    colorPicker
                        .frame(width: width, height:  width)
                        .cornerRadius(width * 0.1)
                        .animation(.easeOut(duration: 0.2), value: colorPicker)
                    
                    Image(systemName: "waveform.path")
                        .resizable()
                        .padding()
                        .frame(width: size / 1.5, height:  size / 1.5)
                        .modifier(WigglingAnimationModifier(isPressed: $soundController.soundModel.buttonAnimation))
                }
                
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        if !soundController.soundModel.isSelected {
                            startTone()
                        }
                        
                    })
                    .onEnded({ _ in
                        if !soundController.soundModel.isSelected {
                            stopTone()
                        }
                        
                    })
            )
        }
        .animation(.spring(), value: size)
    }
    
    private func startTone() {
        soundController.soundModel.buttonAnimation = true
        unit.toneCount = 64000
        unit.setFrequency(freq: soundController.soundModel.hertz * 100)
        unit.setToneVolume(vol: Double(soundController.soundModel.volume))
        unit.enableSpeaker()
        unit.startTone()
    }
    
    private func stopTone() {
        unit.stopTone()
        soundController.soundModel.buttonAnimation = false
        unit.stop()
    }
}



struct Button_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            SoundButton(soundController: SoundController(), size: screen.size.width)
            
        }
    }
}
