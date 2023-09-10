//
//  ViewController.swift
//  EggTimer
//
//  Created by Анастасия Рыбакова on 15.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var player: AVAudioPlayer?
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    let eggTimes = ["Soft" : 5, "Medium" : 8, "Hard" : 12]
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //        print(sender.currentTitle)
        let hardness = sender.currentTitle ?? "No title"
        print(eggTimes[hardness] ?? "No data")
        secondsPassed = 0
        totalTime = eggTimes[hardness] ?? 60
        titleLabel.text = hardness
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(updateTimer),
                             userInfo: nil,
                             repeats: true)
        
//        Stack OverFlow
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//            if self.secondsRemaining > 0 {
//                print ("\(self.secondsRemaining) seconds")
//                self.secondsRemaining -= 1
//                } else {
//                    Timer.invalidate()
//                }
//            }
    
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            print ("\(totalTime - secondsPassed) seconds")
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            self.playSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.titleLabel.text = "How do you like your eggs?"
                self.progressBar.progress = 0.0
            }
        }
    }
    
    // Проигрываем музыку
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
}





