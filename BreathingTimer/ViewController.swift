//
//  ViewController.swift
//  BreathingTimer
//
//  Created by Scott DiBenedetto on 5/7/24.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var secondsRemaining = 60
    var player: AVAudioPlayer!
    var timerPlaying = false
    var resume = 0
    
    

    @IBOutlet weak var stopLabel: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func timePressed(_ sender: UIButton) {
        
        if timerPlaying {
            player.stop()
            timerPlaying = false
            
        }
        
        secondsRemaining = sender.tag
        
        startTimer()
        stopLabel.setTitle("Stop", for: .normal)
        timerLabel.text = "\(secondsRemaining)"
        
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        timer.invalidate()
        
        if timerPlaying {
            player.stop()
            timerPlaying = false
            
        }
        if secondsRemaining > 1 {
            stopLabel.setTitle("Resume", for: .normal)
            resume += 1
        }

        if resume % 2 == 0 {
            stopLabel.setTitle("Stop", for: .normal)
            startTimer()
            
        }
        //print(resume)
        //print(secondsRemaining)
        if secondsRemaining < 2 && resume % 2 == 0 {
            //print("runs")
            if timerPlaying {
                player.stop()
                timerPlaying = false
                
            }
            timer.invalidate()
        }
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        if secondsRemaining > 1 {
            secondsRemaining -= 1
            timerLabel.text = "\(secondsRemaining)"
            //print("\(secondsRemaining) seconds")
            
        } else {
            timer.invalidate()
            timerLabel.text = "Done"
            playSound(soundName: "OceanSound")
            timerPlaying = true
            resume = 0
            
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

