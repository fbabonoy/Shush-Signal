//
//  SoundModel.swift
//  Dog
//
//  Created by fernando babonoyaba on 11/1/23.
//

import Foundation
import SwiftUI

struct SoundModel: Codable {
    var volume: Float
    var hertz: Double
    var isSelected: Bool
    var buttonAnimation: Bool
}

class SoundController: ObservableObject {
    @Published var soundModel: SoundModel {
        didSet {
            if let encode = try? JSONEncoder().encode(soundModel) {
                UserDefaults.standard.set(encode, forKey: "whistle")
            }
        }
    }
    
    let tone: ToneV2
    
    var continuousButtonColor: Color {
        if soundModel.isSelected {
            return Color.green
        }
        
        return .init(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    init() {
           if let getData = UserDefaults.standard.data(forKey: "whistle"),
              let decoded = try? JSONDecoder().decode(SoundModel.self, from: getData) {
               self.soundModel = decoded
           } else {
               // Set a default value if decoding fails
               self.soundModel = SoundModel(volume: 0.25, hertz: 50.0, isSelected: false, buttonAnimation: false)
           }

           self.tone = ToneV2()
       }
    
    func toggleContinuous() {
        soundModel.isSelected.toggle()
        if soundModel.buttonAnimation {
            soundModel.buttonAnimation.toggle()
            tone.stop()
        }
    }

    func resetOnRotation() {
        soundModel.buttonAnimation = false
        tone.stop()
    }
    
}
