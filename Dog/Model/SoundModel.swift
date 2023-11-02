//
//  SoundModel.swift
//  Dog
//
//  Created by fernando babonoyaba on 11/1/23.
//

import Foundation

struct SoundModel{
    var volume: Float
    var hertz: Double
    var isSelected: Bool
    var buttonAnimation: Bool
    var sound: ToneV2
}

class SoundController: ObservableObject {
    @Published var soundModel: SoundModel
    

    
    init() {
        self.soundModel = SoundModel(volume: 0.25, hertz: 50.0, isSelected: false, buttonAnimation: false, sound: ToneV2())
    }
    
    func toggleContinuous() {
        soundModel.isSelected.toggle()
        if soundModel.buttonAnimation {
            soundModel.buttonAnimation.toggle()
            soundModel.sound.stop()
        }
    }
}
