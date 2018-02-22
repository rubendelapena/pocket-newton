//
//  Question.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 2/21/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import Foundation

class Question {
    internal var question: String
    internal var answer: String
    internal var wrongAnswers: [String]
    
    public init(question: String, answer: String, wrongAnswers: [String]) {
        self.question = question
        self.answer = answer
        self.wrongAnswers = wrongAnswers
    }
}
