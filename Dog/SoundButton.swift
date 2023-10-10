//
//  Button.swift
//  Dog
//
//  Created by fernando babonoyaba on 9/11/23.
//

import SwiftUI
import AVFoundation

struct SoundButton: View {
    @State private var isWiggling = false

    
    var size: CGSize
    var volume: Float
    var hertz: Double
    let unit = ToneOutputUnit()
    @State private var ringIcon = false

    //TODO: this needs to have an observer to constantly get the volume.
    // at the least i nee to update everytime the volume is set on the app with the fisical buttons
    private var image: String {

        if getVolumePercentage() > 0.75 {
            return "speaker.wave.3"
        } else if volume > 0.30 {
            return "speaker.wave.2"
        } else if volume > 0 {
            return "speaker.wave.1"
        }
        print("Current Volume Percentage: \(getVolumePercentage())%")

        return "speaker.slash"
        
    }
    
    private var colorPicker: Color {
        isWiggling == true ? .green : .init(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    private var width: Double {
        colorPicker == .green ? size.width * 0.95 : size.width
    }
    
    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    var body: some View {
        
        Button {

        } label: {
            ZStack {
                Color.init(red: 0.0, green: 0.5, blue: 0.0)
                    .frame(width: size.width, height:  size.width)
                    .cornerRadius(size.width)
                
                colorPicker
                    .frame(width: width, height:  width)
                    .cornerRadius(width)
                    .animation(.easeOut(duration: 0.2), value: colorPicker)
                
                Image(systemName: image)
                    .resizable()
                    .padding()
                    .frame(width: size.width / 1.5, height:  size.width / 1.5)
                    .modifier(WigglingAnimationModifier(isPressed: $isWiggling))

                    
                
            }
            
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    isWiggling = true
                    unit.toneCount = 64000
                    unit.setFrequency(freq: hertz * 100)
                    unit.setToneVolume(vol: Double(volume))
                    unit.enableSpeaker()
                    unit.startToneForDuration(time: 3.0)

                })
                .onEnded({ _ in
                    isWiggling = false
                    unit.stop()

                })
        )
    }
    
    func getVolumePercentage() -> Float {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(true)
            let currentVolume = audioSession.outputVolume
            return currentVolume * 100.0
        } catch {
            print("Error getting volume: \(error)")
            return 0.0
        }
    }


    
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            SoundButton(size: screen.size, volume: 0.30, hertz: 1000.0)
            
        }
    }
}
