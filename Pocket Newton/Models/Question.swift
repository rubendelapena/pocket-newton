//
//  Question.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 2/21/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import Foundation
import Firebase

class Question {
    internal var id: String
    internal var question: String
    internal var answer: String
    internal var wrongAnswers: [String]
    internal var type: QuestionType
    
    public init(snapshot: DataSnapshot, topicID: String) {
        let question = snapshot.value as? NSDictionary
        
        self.id = snapshot.key
        self.question = question?["question"] as? String ?? "Unknown question"
        self.answer = question?["answer"] as? String ?? "Unknown answer"
        self.wrongAnswers = question?["wrong-answers"] as? [String] ?? [String]()
        
        let mediaType = question?["media-type"] as? String ?? "no-media"
        switch mediaType {
        case "no-media":
            self.type = .noMedia
        case "has-image":
            self.type = .hasImage
        default:
            self.type = .noMedia
        }
    }
}
