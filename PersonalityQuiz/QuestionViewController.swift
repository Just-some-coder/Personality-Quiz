//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Aditya Gupta on 23/09/24.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    var questionIndex = 0
    
    var answersChosen : [Answer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    
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
        
        nextQuestion();
        
    }
    
    
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn{
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn{
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
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        }else{
            performSegue(withIdentifier: "Results", sender: nil)
        }
        
    }
    
    func updateSingleStack(using answers : [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]){
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
    
    func updateRangedStack(using answers : [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0, animated: true)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex)/Float(questions.count)
        
        navigationItem.title = "Question #\( questionIndex + 1)"
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        switch currentQuestion.type {
        case .Single:
            updateSingleStack(using: currentAnswers)
        case .Multiple:
            updateMultipleStack(using: currentAnswers)
        case .Ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    
    var questions : [Question] = [
        Question(
            text: "What Motivates you the most in your life ?",
            type: .Single,
            answers: [
                Answer(text: "Adventure", type: .Luffy),
                Answer(text: "Friendship", type: .Nami),
                Answer(text: "Knowledge", type: .Robin),
                Answer(text: "Protecting Others", type: .Jinbe)
            ]
        ),
        Question(
            text: "How do you handle conflict?",
            type: .Single,
            answers: [
                Answer(text: "Head On Confront", type: .Luffy),
                Answer(text: "Find a Compromise", type: .Nami),
                Answer(text: "Strategically Plan", type: .Robin),
                Answer(text: "Use Humor", type: .Ussop)
            ]
        ),
        Question(
            text: "Which traits do you value most in your friends?",
            type: .Multiple,
            answers: [
                Answer(text: "Honesty", type: .Zoro),
                Answer(text: "Humor", type: .Ussop),
                Answer(text: "Kindness", type: .Chopper),
                Answer(text: "Loyalty", type: .Jinbe)
            ]
        ),
        Question(
            text: "What activities do you enjoy the most?",
            type: .Multiple,
            answers: [
                Answer(text: "Building Things", type: .Franky),
                Answer(text: "Telling Tales and Jokes", type: .Ussop),
                Answer(text: "Cooking", type: .Sanji),
                Answer(text: "Music", type: .Brooks)
            ]
        ),
        Question(
            text: "I believe in fighting first and asking questions later.",
            type: .Ranged,
            answers: [
                Answer(text: "True", type: .Luffy),
                Answer(text: "Positive", type: .Zoro),
                Answer(text: "Negative", type: .Nami),
                Answer(text: "False", type: .Chopper)
            ]
        ),
        Question(
            text: "I often think about the impact of my actions on others",
            type: .Ranged,
            answers: [
                Answer(text: "Very Much", type: .Jinbe),
                Answer(text: "Somewhat", type: .Nami),
                Answer(text: "Not at all", type: .Sanji),
                Answer(text: "Never", type: .Robin)
            ]
        ),
        Question(
            text: "If you encountered a treasure map, what would you do?",
            type: .Single,
            answers: [
                Answer(text: "Search For It", type: .Luffy),
                Answer(text: "Analyze it", type: .Robin),
                Answer(text: "Sell It", type: .Nami),
                Answer(text: "Tell Others", type: .Ussop)
            ]
        ),
        Question(
            text: "When faced with a tough decision, you usually",
            type: .Single,
            answers: [
                Answer(text: "Charge Ahead", type: .Luffy),
                Answer(text: "Think Logically", type: .Robin),
                Answer(text: "Consult Others", type: .Jinbe),
                Answer(text: "Go With Your Gut", type: .Zoro)
            ]
        ),
        Question(
            text: "If you could build any ship, what would it be like?",
            type: .Single,
            answers: [
                Answer(text: "Massive and Invincible", type: .Franky),
                Answer(text: "Sleek and Fast", type: .Nami),
                Answer(text: "All weather resiliant", type: .Jinbe),
                Answer(text: "Full of surprises", type: .Ussop)
            ]
        ),
        Question(
            text: "What is your ideal way to celebrate a victory?",
            type: .Single,
            answers: [
                Answer(text: "Big Feast", type: .Sanji),
                Answer(text: "Build Something", type: .Franky),
                Answer(text: "Burst Into Song", type: .Brooks),
                Answer(text: "Share the Victory", type: .Ussop)
            ]
        ),
        
    ]
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
