//
//  QuestionController.swift
//  Personal Quiz
//
//  Created by  Apple24 on 06/12/2018.
//  Copyright © 2018  Apple24. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
  
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabelL: UILabel!
    @IBOutlet weak var rangedLabelR: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // MARK: - Properties
    var questions: [Question] = [
        Question(text: "Что вы предпочитаете?", type: .single, answers:[
            Answer(text: "Мясо", type: .dog),
            Answer(text: "Рыбу", type: .cat),
            Answer(text: "Морковку", type: .rabbit),
            Answer(text: "Капусту", type: .turtle),
        ]),
        Question(text: "Какие виды деятельности любите?", type: .multiple, answers:[
            Answer(text: "Плавать", type: .turtle),
            Answer(text: "Спать", type: .cat),
            Answer(text: "Прыгать", type: .rabbit),
            Answer(text: "Грызть тапки", type: .dog),
        ]),
        Question(text: "Как вы относитесь к поездкам?", type: .ranged, answers:[
            Answer(text: "Ненавижу", type: .cat),
            Answer(text: "Они меня нервируют", type: .rabbit),
            Answer(text: "Не замечаю", type: .turtle),
            Answer(text: "Обажаю", type: .dog),
        ]),
    ]

    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultsViewController = segue.destination as! ResultsController
            resultsViewController.responces = answersChosen
            questionIndex = 0
            answersChosen = []
            updateUI()
        }
    }
    // MARK: - Methohs
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
       
        navigationItem.title = "Вопрос № \(questionIndex + 1) "
        let question = questions[questionIndex]
        let answers = question.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = question.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch question.type {
        case .single:
            updateSingleStack(using: answers)
        case .multiple:
            updateMultipleStack(using: answers)
        case .ranged:
            updateRangedStack(using: answers)
        }
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: true)
        rangedLabelL.text = answers.first?.text
        rangedLabelR.text = answers.last?.text
    }
    
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    // MARK: - @IBAction
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }

    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}
