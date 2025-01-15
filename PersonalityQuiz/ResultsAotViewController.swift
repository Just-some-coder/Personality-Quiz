//
//  ResultsAotViewController.swift
//  PersonalityQuiz
//
//  Created by Aditya Gupta on 26/09/24.
//

import UIKit

class ResultsAotViewController: UIViewController {
    
    init?(coder: NSCoder, responses: [AnswerAot]){
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    var responses : [AnswerAot]
    
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResults()
        navigationItem.hidesBackButton = true
    }
    
    func calculatePersonalityResults(){
        let frequencyOfAnswers = responses.reduce(into:
                                                    [AotType : Int]()){(counts, answer) in
            if let existingCount = counts[answer.type]{
                counts[answer.type] = existingCount + 1
            }else{
                counts[answer.type] = 1
            }
        }
        

        
        let mostCommonAnswer = frequencyOfAnswers.sorted {
            $0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "\(mostCommonAnswer.rawValue)"
        
        
        let image = UIImage(named: mostCommonAnswer.rawValue)
        answerImage.image = image;
        
        }
    
        
    
    }
    



