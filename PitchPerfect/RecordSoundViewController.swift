//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Shane Richards on 4/18/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    enum RecordingState {
        case recording, notRecording
    }
    
    func configureUI(recordingState: RecordingState) {
        switch recordingState {
            case .recording:
                stopButton.isEnabled = true
                recordButton.isEnabled = false
                recordingLabel.text = "Recording in progress"
            case .notRecording:
                stopButton.isEnabled = false
                recordButton.isEnabled = true
                recordingLabel.text = "Tap to Record"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(recordingState: .notRecording)
    }


    @IBAction func recordAudio(_ sender: Any) {
        configureUI(recordingState: .recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()

        try! session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])

        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(recordingState: .notRecording)
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully isSuccessful: Bool) {
        if isSuccessful {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
            configureUI(recordingState: .notRecording)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playsSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playsSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

