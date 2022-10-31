//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Роман Бакаев on 28.10.2022.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    
    private let questions = Question.getQuestions()
    private var currentAnswers : [Answer] {
        questions[questionIndex].answers
    }
    private var answersChosen:[Answer] = []
    private var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
     updateUI() // метод который обновляет элементы интерфейса в соответствии с категорией ответов
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else {return}
        resultVC.answers = answersChosen
    
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else {return}
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
}
// MARK: Private methods

extension QuestionViewController {
    private func updateUI() {
    //hide stacks:
    for stackView in [singleStackView, multipleStackView, rangedStackView] {
        stackView?.isHidden = true
}
        //get current question
        let currentQuestion = questions[questionIndex]
        
    // set current question for question label
        questionLabel.text = currentQuestion.title
        
        //calculate Progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //set progress for question progress View
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // set navigation title
        title = "вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.type)
        
}
    private func showCurrentAnswers(for type:ResponseType){
        switch type {
            
        case .single:showSingleStackView(with:currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged:showRangedStackView(with: currentAnswers)
            break
        }
    }

    private func showSingleStackView(with answers: [Answer]){
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers){
            button.setTitle(answer.title, for: .normal)
        }
    }
    private func showMultipleStackView (with answers:[Answer]){
        multipleStackView.isHidden.toggle()
        for(label,answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    private func showRangedStackView( with answers: [Answer]){
        rangedStackView.isHidden.toggle()
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
