//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Aditya Gupta on 23/09/24.
//

import UIKit

class ResultsViewController: UIViewController {
    
    init?(coder: NSCoder, responses: [Answer]){
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    var responses : [Answer]
    
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    
    @IBOutlet weak var resultDefinitionLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResults()
        navigationItem.hidesBackButton = true
    }
    
    func calculatePersonalityResults(){
        let frequencyOfAnswers = responses.reduce(into:
                                                    [NakamaType : Int]()){(counts, answer) in
            if let existingCount = counts[answer.type]{
                counts[answer.type] = existingCount + 1
            }else{
                counts[answer.type] = 1
            }
        }
        
//        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
//            { (pair1, pair2) in
//            return pair1.value > pair2.value
//        })
        
        let mostCommonAnswer = frequencyOfAnswers.sorted {
            $0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "\(mostCommonAnswer.rawValue)"
        
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
        let image = UIImage(named: mostCommonAnswer.rawValue)
        answerImage.image = image;
        
        }
    
        
    
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



