//
//  ViewController.swift
//  SliderGame
//
//  Created by Denys Brodskyi on 07.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    var targetValue = 0
    var score = 0
    var round = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHiglighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHiglighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let resizableLeft = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(resizableLeft, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let resizableRight = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(resizableRight, for: .normal)
        
        newRound()
    }
    
    @IBAction func restart() {
        score = 0
        round = 1
        newRound()
    }
    
    func newRound() {
        targetValue = Int.random(in: 1...100)
        targetLabel.text = "\(targetValue)"
        roundLabel.text = "\(round)"
        scoreLabel.text = "\(score)"
        slider.value = 50
        
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func showAlert() {
        
        let currentValue = lroundf(slider.value)
        let diffrence = abs(currentValue - targetValue)
        var currentScore = 100 - diffrence

        let title: String
        if diffrence == 0 {
            title = "Ідеально!"
            currentScore += 100
        } else if diffrence < 5 {
            title = "Майже вдалось!"
            if diffrence < 3 {
                currentScore += 50
            }
        } else if diffrence < 10 {
            title = "Непогано!"
        } else {
            title = "Мимо:("
        }
        
        let message = "Ви набрали: \(currentScore) балів"
        
        let alertWindow = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрити", style: .default) { _ in
            self.newRound()
        }
        
        alertWindow.addAction(action)
        present(alertWindow, animated: true)
        
        score += currentScore
        round += 1
    }
    
}

