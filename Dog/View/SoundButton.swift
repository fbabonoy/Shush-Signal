//
//  Button.swift
//  Dog
//
//  Created by fernando babonoyaba on 9/11/23.
//

import SwiftUI
import AVFoundation

struct SoundButton: View {
    
    @Binding var buttonAnimation: Bool
    @Binding var continuous: Bool
    var size: CGFloat
    var volume: Float
    var hertz: Double
    let unit: ToneV2
    
    private var colorPicker: Color {
        buttonAnimation == true ? .green : .init(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    private var width: Double {
        colorPicker == .green ? size * 0.95 : size
    }
    
    var body: some View {
        Button {
            
            if !buttonAnimation && continuous {
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
                    .modifier(WigglingAnimationModifier(isPressed: $buttonAnimation))
            }
            
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    if !continuous {
                        startTone()
                    }
                    
                })
                .onEnded({ _ in
                    if !continuous {
                        stopTone()
                    }
                    
                })
        )
    }
    
    private func startTone() {
        buttonAnimation = true
        unit.toneCount = 64000
        unit.setFrequency(freq: hertz * 100)
        unit.setToneVolume(vol: Double(volume))
        unit.enableSpeaker()
        unit.startTone()
    }
    
    private func stopTone() {
        unit.stopTone()
        buttonAnimation = false
        unit.stop()
    }
}



struct Button_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            SoundButton(buttonAnimation: .constant(false), continuous: .constant(false), size: screen.size.width, volume: 0.30, hertz: 1000.0, unit: ToneV2())
            
        }
    }
}
