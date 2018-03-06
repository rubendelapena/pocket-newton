//
//  QuestionNoMediaView.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 3/4/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit

class QuestionNoMediaView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var questionLabel: UILabel!
    @IBOutlet weak private var firstOptionButton: AnswerButton!
    @IBOutlet weak private var secondOptionButton: AnswerButton!
    @IBOutlet weak private var thirdOptionButton: AnswerButton!
    @IBOutlet weak private var fourthOptionButton: AnswerButton!
    
    @IBOutlet private var answerButtons: [AnswerButton]!
    
    private var correctAnswer: AnswerButton!
    
    internal var parent: QuizViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public init(frame: CGRect, question: Question) {
        super.init(frame: frame)
        self.commonInit()
        self.set(question: question)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("QuestionNoMedia", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func set(question: Question) {
        self.questionLabel.text = question.question
        
        var correctAnswerButton = Int(arc4random_uniform(4))
        var numOfWrongAnswers = 0
        
        for button in self.answerButtons {
            if correctAnswerButton == numOfWrongAnswers {
                button.set(text: question.answer)
                button.isTheCorrectAnswer = true
                self.correctAnswer = button
                correctAnswerButton = -1
            } else {
                button.set(text: question.wrongAnswers[numOfWrongAnswers])
                button.isTheCorrectAnswer = false
                numOfWrongAnswers = numOfWrongAnswers + 1
            }
        }
    }
    
    @IBAction func answered(_ sender: AnswerButton) {
        for button in self.answerButtons {
            button.showAnswer()
            button.isEnabled = false
        }
    }

}
