//
//  QuestionNoMediaView.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 3/4/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit

class QuestionNoMediaView: UIView {
    
    private var parent: QuizViewController!
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var questionLabel: UILabel!
    @IBOutlet weak private var firstOptionButton: AnswerButton!
    @IBOutlet weak private var secondOptionButton: AnswerButton!
    @IBOutlet weak private var thirdOptionButton: AnswerButton!
    @IBOutlet weak private var fourthOptionButton: AnswerButton!
    @IBOutlet private var answerButtons: [AnswerButton]!
    
    private var correctButton: AnswerButton!
    private var wrongButtons: [AnswerButton] {
        return self.answerButtons.filter({$0.isTheCorrectAnswer == false})
    }
    private var userResult: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public init(frame: CGRect, question: Question, parent: QuizViewController) {
        super.init(frame: frame)
        self.commonInit()
        self.set(question: question)
        self.parent = parent
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("QuestionNoMedia", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        for button in self.answerButtons {
            button.isHidden = true
            Timer.scheduledTimer(timeInterval: 2, target: self,   selector: (#selector(QuestionNoMediaView.showOptions)), userInfo: nil, repeats: false)
        }
    }
    
    private func set(question: Question) {
        self.questionLabel.text = question.question
        
        var correctAnswerButton = Int(arc4random_uniform(4))
        var numOfWrongAnswers = 0
        
        for button in self.answerButtons {
            if correctAnswerButton == numOfWrongAnswers {
                button.set(text: question.answer)
                button.isTheCorrectAnswer = true
                self.correctButton = button
                correctAnswerButton = -1
            } else {
                button.set(text: question.wrongAnswers[numOfWrongAnswers])
                button.isTheCorrectAnswer = false
                numOfWrongAnswers = numOfWrongAnswers + 1
            }
        }
    }
    
    @IBAction func answered(_ sender: AnswerButton) {
        // Disable buttons.
        for button in self.answerButtons {
            button.isEnabled = false
        }
        
        if sender == self.correctButton {
            self.correctButton.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
            Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(QuestionNoMediaView.showCorrectAnswer)), userInfo: nil, repeats: false)
        }

        Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(QuestionNoMediaView.hideWrongAnswerButtons)), userInfo: nil, repeats: false)
        
        // Hide this view.
        Timer.scheduledTimer(timeInterval: 3.5, target: self,   selector: (#selector(QuestionNoMediaView.hide)), userInfo: nil, repeats: false)
    }
    
    // MARK: - Animations
    
    @objc private func hideWrongAnswerButtons() {
        for button in self.wrongButtons {
            UIView.transition(with: button, duration: 1, options: .transitionCrossDissolve, animations: {
                button.isHidden = true
            })
        }
    }
    
    @objc private func showCorrectAnswer() {
        UIView.transition(with: self.correctButton, duration: 0.7, options: .transitionCrossDissolve, animations: {
            self.correctButton.backgroundColor = .green
        })
    }
    
    @objc private func hide() {
        UIView.transition(with: self, duration: 1, options: .transitionCrossDissolve, animations: {
            self.isHidden = true
        }) { (true) in
            self.parent.doneAnswering(withResult: self.userResult)
            self.removeFromSuperview()
        }
    }
    
    @objc private func showOptions() {
        for button in self.answerButtons {
            UIView.transition(with: button, duration: 1, options: .transitionCrossDissolve, animations: {
                button.isHidden = false
            })
        }
    }
}
