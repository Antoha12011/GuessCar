//
//  ViewController.swift
//  GuessCar
//
//  Created by Anton Pavlov on 03.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet var highestScoreLabel: UILabel!
    @IBOutlet var alert: UILabel!
    
    var cars = [String]()
    var score = 0
    var correctAnswer = 0
    var numOfQuestionsAsked = 0
    var highestScore: Int = 0
    var buttonAnimation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars += ["Ford", "Honda", "Mazda", "Hyundai", "Renault", "Skoda", "Mitsubishi", "Volkswagen", "Acura", "Infiniti", "Subaru", "Scion", "Suzuki", "Lexus", "Cadillac", "Chevrolet", "Chrysler", "GMC", "Tesla", "Jeep", "Porsche", "Bentley", "Fiat", "Citroen", "Jaguar", "Aston Martin", "Mini", "Volvo", "Seat", "Lamborghini", "Bmw", "Audi", "Mercedes-Benz", "Kia", "Toyota", "Nissan", "Opel", "Range Rover", "Rolls-Royce", "Hummer", "Ferrari", "Dodge"]
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        let defaults = UserDefaults.standard
        highestScoreLabel.text = String(defaults.integer(forKey: "Макс. рекорд"))
        highestScore = defaults.integer(forKey: "Макс. рекорд")
        
        askQuestions()
    }
    
    
    func askQuestions(action: UIAlertAction! = nil) {
        cars.shuffle()
        correctAnswer = Int.random(in: 1...2)
        button1.setImage(UIImage(named: cars[0]), for: .normal)
        button1.imageView?.contentMode = .scaleAspectFit
        button2.setImage(UIImage(named: cars[1]), for: .normal)
        button2.imageView?.contentMode = .scaleAspectFit
        button3.setImage(UIImage(named: cars[2]), for: .normal)
        button3.imageView?.contentMode = .scaleAspectFit
        
        title = cars[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            buttonAnimation = button1
        case 1:
            buttonAnimation = button2
        case 2:
            buttonAnimation = button3
        default:
            break
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.buttonAnimation.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (_) in
            UIView.animate(withDuration: 0.3) {
                self.buttonAnimation.transform = CGAffineTransform.identity
            }
        }
        
        if correctAnswer == sender.tag {
            title = "Правильно!"
            score += 1
        } else {
            title = "Будь внимательнее!"
            score -= 1
        }
        
        scoreDisplay.text = String(score)
        if score > highestScore {
            highestScoreLabel.text = String(score)
            let defaults = UserDefaults.standard
            defaults.set(score, forKey: "Макс. рекорд")
        }
        numOfQuestionsAsked += 1
        level.text = String(numOfQuestionsAsked)
        
        let ac: UIAlertController
        if numOfQuestionsAsked == 20 {
            ac = UIAlertController(title: title, message: "Твой финальный балл \(score)", preferredStyle: .alert)
            
            score = 0
            numOfQuestionsAsked = 0
            
            ac.addAction(UIAlertAction(title: "Заново", style: .default, handler: askQuestions))
        } else {
            ac = UIAlertController(title: title, message: "Твой балл \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: askQuestions))
        }
        present(ac, animated: true)
        
    }
    
}
