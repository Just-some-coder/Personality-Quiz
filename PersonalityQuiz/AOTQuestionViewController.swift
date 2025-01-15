//
//  AOTQuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Aditya Gupta on 26/09/24.
//

import UIKit

class AOTQuestionViewController: UIViewController {
    
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
    
    var answersChosen : [AnswerAot] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    


    
    @IBSegueAction func showResultsAot(_ coder: NSCoder) -> ResultsAotViewController? {
        return ResultsAotViewController(coder: coder, responses: answersChosen)
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
            performSegue(withIdentifier: "ResultsAOT", sender: nil)
        }
        
    }
    
    func updateSingleStack(using answers : [AnswerAot]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [AnswerAot]){
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
    
    func updateRangedStack(using answers : [AnswerAot]){
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

    
    var questions: [QuestionAot] = [
        QuestionAot(
            text: "What drives your determination to fight?",
            type: .Single,
            answers: [
                AnswerAot(text: "To achieve freedom for all", type: .Eren),
                AnswerAot(text: "To protect those I love", type: .Mikasa),
                AnswerAot(text: "To uncover the truth about the world", type: .Armin),
                AnswerAot(text: "To protect humanity and my comrades", type: .Levi)
            ]
        ),
        
        QuestionAot(
            text: "Which qualities do you value in your allies? (Choose multiple)",
            type: .Multiple,
            answers: [
                AnswerAot(text: "Bravery", type: .Eren),
                AnswerAot(text: "Loyalty", type: .Mikasa),
                AnswerAot(text: "Intelligence", type: .Armin),
                AnswerAot(text: "Strength and strategy", type: .Erwin)
            ]
        ),
        
        QuestionAot(
            text: "How important is freedom to you?",
            type: .Ranged,
            answers: [
                AnswerAot(text: "Not at All", type: .Levi),
                AnswerAot(text: "Somewhat important", type: .Erwin),
                AnswerAot(text: "Very important", type: .Armin),
                AnswerAot(text: "Most Important", type: .Eren)
            ]
        ),
        
        QuestionAot(
            text: "How do you handle difficult choices in battle?",
            type: .Single,
            answers: [
                AnswerAot(text: "I charge in and face it head-on", type: .Eren),
                AnswerAot(text: "I protect my friends first", type: .Mikasa),
                AnswerAot(text: "I think strategically before acting", type: .Armin),
                AnswerAot(text: "I lead with experience and calm", type: .Erwin)
            ]
        ),
        
        QuestionAot(
            text: "What do you think is the most important trait in a leader?",
            type: .Single,
            answers: [
                AnswerAot(text: "Fearlessness", type: .Eren),
                AnswerAot(text: "Compassion", type: .Mikasa),
                AnswerAot(text: "Wisdom", type: .Armin),
                AnswerAot(text: "Vision and resolve", type: .Levi)
            ]
        ),
        
        QuestionAot(
            text: "What is your greatest fear? (Choose multiple)",
            type: .Multiple,
            answers: [
                AnswerAot(text: "Being trapped without freedom", type: .Eren),
                AnswerAot(text: "Losing those I care about", type: .Mikasa),
                AnswerAot(text: "Not being able to protect others", type: .Armin),
                AnswerAot(text: "Failure to lead and protect", type: .Erwin)
            ]
        ),
        
        QuestionAot(
            text: "How well do you cope with loss?",
            type: .Ranged,
            answers: [
                AnswerAot(text: "Not well", type: .Eren),
                AnswerAot(text: "I struggle but push through", type: .Mikasa),
                AnswerAot(text: "I cope moderately well", type: .Armin),
                AnswerAot(text: "Fuel My Resolve", type: .Levi)
            ]
        ),
        
        QuestionAot(
            text: "What inspires you to keep moving forward?",
            type: .Single,
            answers: [
                AnswerAot(text: "My vision of a free world", type: .Eren),
                AnswerAot(text: "The safety of my friends", type: .Mikasa),
                AnswerAot(text: "The pursuit of knowledge", type: .Armin),
                AnswerAot(text: "The hope for a united humanity", type: .Erwin)
            ]
        ),
        
        QuestionAot(
            text: "In a critical moment, what would you rely on? (Choose multiple)",
            type: .Multiple,
            answers: [
                AnswerAot(text: "My instincts and passion", type: .Eren),
                AnswerAot(text: "My combat skills", type: .Mikasa),
                AnswerAot(text: "My strategic thinking", type: .Armin),
                AnswerAot(text: "My leadership and tactical experience", type: .Levi)
            ]
        ),
        
        QuestionAot(
            text: "What legacy do you hope to leave behind?",
            type: .Ranged,
            answers: [
                AnswerAot(text: "A Shackled World", type: .Eren),
                AnswerAot(text: "A legacy of love and loyalty", type: .Mikasa),
                AnswerAot(text: "A thirst for knowledge and understanding", type: .Armin),
                AnswerAot(text: "A Free World", type: .Erwin)
            ]
        )
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
