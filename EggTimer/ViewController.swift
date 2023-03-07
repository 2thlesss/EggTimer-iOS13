//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var timeDisplay: UILabel!
    
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var timer = Timer()
    var player : AVAudioPlayer?
    
    
    
    @IBAction func hardnessSelected(_ sender: Any) {
        
        
        
        timer.invalidate()
        if let hardness = (sender as AnyObject).currentTitle {
            let time = eggTimes[hardness!]!
            var seconds = time
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] timer in
                if seconds >= 0 {
                    timeDisplay.text = ("\(seconds)")
                    let progress = Float(seconds) / Float(time)
                    print(progress)
                    progressBar.progress = 1.0 - progress // Invert progress direction
                    print(progressBar.progress)
                    seconds -= 1
                } else {
                    self.timer.invalidate()
                    timeDisplay.text = ("Done!!!")
                    playSound(soundName: "alarm_sound")
                }
            })
        } else {
            print("Invalid hardness level")
            
        }
        func playSound(soundName: String){
            let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
        
    }
}
