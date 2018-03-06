//
//  ReadyQuizView.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 3/5/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit

class ReadyQuizView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var questionNumber: UILabel!
    
    internal var parent: QuizViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(frame: CGRect, questionNumber: Int, parent: QuizViewController) {
        super.init(frame: frame)
        commonInit()
        self.questionNumber.text = "Question " + String(questionNumber)
        self.parent = parent
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ReadyQuiz", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func beginNextQuestion(_ sender: UIButton) {
        self.parent.showNextQuestion()
    }
    

}
