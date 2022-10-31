//
//  ResultViewController.swift
//  Personality Quiz
//
//  Created by Роман Бакаев on 28.10.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var animalDescription: UILabel!
    
    
    var answers: [Answer]!
    
   private var dogCount = 0
   private var catCount = 0
   private var rabbitCount = 0
   private var turtleCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
       
        for answer in answers {
            if answer.animal == .dog {
                self.dogCount += 1
            } else if answer.animal == .cat {
                self.catCount += 1
            } else if answer.animal == .rabbit {
                self.rabbitCount += 1
            } else if answer.animal == .turtle {
                self.turtleCount += 1
            }
            }
        
        if dogCount > catCount && dogCount > rabbitCount && dogCount > turtleCount {
            animalLabel.text = "Вы - \(Animal.dog.rawValue)"
            animalDescription.text = Animal.dog.definition
        } else if catCount > dogCount && catCount > rabbitCount && catCount > turtleCount {
            animalLabel.text = "Вы - \(Animal.cat.rawValue)"
            animalDescription.text = Animal.cat.definition
        } else if rabbitCount > dogCount && rabbitCount > catCount && rabbitCount > turtleCount {
            animalLabel.text = "Вы - \(Animal.rabbit.rawValue)"
            animalDescription.text = Animal.rabbit.definition
        } else if turtleCount > dogCount && turtleCount > catCount && turtleCount > rabbitCount {
            animalLabel.text = "Вы - \(Animal.turtle.rawValue)"
            animalDescription.text = Animal.turtle.definition
        } else {
            animalLabel.text = "Вы - \(answers.first!.animal.rawValue)"
            animalDescription.text = answers.first!.animal.definition
        }
        
        
    }
    

    

}
