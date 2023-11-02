//
//  ToneV2.swift
//  Dog
//
//  Created by fernando babonoyaba on 10/24/23.
//

import Foundation
import AudioUnit
import AVFoundation


final class ToneV2: NSObject {
    var auAudioUnit: AUAudioUnit! = nil
    var avActive = false
    var audioRunning = false
    var sampleRate: Double = 44100.0
    var f0 = 880.0
    var v0 = 16383.0
    var toneCount: Int32 = 0
    private var phY = 0.0
    private var interrupted = false
    var isTonePlaying = false  // Flag to track tone state

    func startTone() {
        if !isTonePlaying {
            toneCount = Int32.max
            isTonePlaying = true
        }
    }

    func stopTone() {
        isTonePlaying = false
    }

    func setFrequency(freq: Double) {
        f0 = freq
    }

    func setToneVolume(vol: Double) {
        v0 = vol * 32766.0
    }

    func setToneTime(t: Double) {
        toneCount = Int32(t * sampleRate)
    }

    func enableSpeaker() {
        if audioRunning {
            return
        }
        if avActive == false {
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(AVAudioSession.Category.soloAmbient)
                var preferredIOBufferDuration = 4.0 * 0.0058
                let hwSRate = audioSession.sampleRate
                if hwSRate == 48000.0 {
                    sampleRate = 48000.0
                }
                if hwSRate == 48000.0 {
                    preferredIOBufferDuration = 4.0 * 0.0053
                }
                let desiredSampleRate = sampleRate
                try audioSession.setPreferredSampleRate(desiredSampleRate)
                try audioSession.setPreferredIOBufferDuration(preferredIOBufferDuration)
                NotificationCenter.default.addObserver(
                    forName: AVAudioSession.interruptionNotification,
                    object: nil,
                    queue: nil,
                    using: myAudioSessionInterruptionHandler)
                try audioSession.setActive(true)
                avActive = true
            } catch {
                // Handle error (audio system broken?)
            }
        }

        do {
            let audioComponentDescription = AudioComponentDescription(
                componentType: kAudioUnitType_Output,
                componentSubType: kAudioUnitSubType_RemoteIO,
                componentManufacturer: kAudioUnitManufacturer_Apple,
                componentFlags: 0,
                componentFlagsMask: 0
            )

            if auAudioUnit == nil {
                try auAudioUnit = AUAudioUnit(componentDescription: audioComponentDescription)
                let bus0 = auAudioUnit.inputBusses[0]
                guard let audioFormat = AVAudioFormat(
                    commonFormat: AVAudioCommonFormat.pcmFormatInt16,
                    sampleRate: Double(sampleRate),
                    channels: AVAudioChannelCount(2),
                    interleaved: true
                ) else { return }
                try bus0.setFormat(audioFormat)
                auAudioUnit.outputProvider = { (
                    actionFlags,
                    timestamp,
                    frameCount,
                    inputBusNumber,
                    inputDataList
                ) -> AUAudioUnitStatus in
                    self.fillSpeakerBuffer(inputDataList: inputDataList, frameCount: frameCount)
                    return (0)
                }
            }
            auAudioUnit.isOutputEnabled = true
            toneCount = 0
            try auAudioUnit.allocateRenderResources()
            try auAudioUnit.startHardware()
            audioRunning = true
        } catch {
            // Handle error
        }
    }

    private func fillSpeakerBuffer(
        inputDataList: UnsafeMutablePointer<AudioBufferList>,
        frameCount: UInt32
    ) {
        let inputDataPtr = UnsafeMutableAudioBufferListPointer(inputDataList)
        let nBuffers = inputDataPtr.count
        if nBuffers > 0 {
            let mBuffers: AudioBuffer = inputDataPtr[0]
            let count = Int(frameCount)
            if isTonePlaying {
                var v = v0
                if v > 32767 {
                    v = 32767
                }
                let sz = Int(mBuffers.mDataByteSize)
                var a = phY
                let d = 2.0 * .pi * f0 / sampleRate
                let bufferPointer = UnsafeMutableRawPointer(mBuffers.mData)
                if var bptr = bufferPointer {
                    for i in 0 ..< count {
                        let u = sin(a)
                        a += d
                        if a > 2.0 * .pi {
                            a -= 2.0 * .pi
                        }
                        let x = Int16(v * u + 0.5)
                        if i < (sz / 2) {
                            bptr.assumingMemoryBound(to: Int16.self).pointee = x
                            bptr += 2
                            bptr.assumingMemoryBound(to: Int16.self).pointee = x
                            bptr += 2
                        }
                    }
                }
                phY = a
                toneCount -= Int32(frameCount)
            } else {
                memset(mBuffers.mData, 0, Int(mBuffers.mDataByteSize))
            }
        }
    }

    func stop() {
        if audioRunning {
            auAudioUnit.stopHardware()
            audioRunning = false
        }
        if avActive {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(false)
            } catch {
                // Handle error
            }
            avActive = false
        }
    }

    private func myAudioSessionInterruptionHandler(notification: Notification) {
        let interuptionDict = notification.userInfo
        if let interuptionType = interuptionDict?[AVAudioSessionInterruptionTypeKey] {
            let interuptionVal = AVAudioSession.InterruptionType(
                rawValue: (interuptionType as AnyObject).uintValue
            )
            if interuptionVal == AVAudioSession.InterruptionType.began {
                if audioRunning {
                    auAudioUnit.stopHardware()
                    audioRunning = false
                    interrupted = true
                }
            }
        }
    }
}

