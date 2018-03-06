//
//  Topic.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 2/21/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import Foundation
import Firebase

class Topic {
    internal var id: String
    internal var name: String
    internal var questions: [Question]?
    internal var numOfProblems: Int
    internal var numOfTheoryQuestions: Int
    internal var courseID: String
    
    public init(snapshot: DataSnapshot, courseID: String) {
        let topic = snapshot.value as? NSDictionary
        
        self.id = snapshot.key
        self.name = topic?["name"] as? String ?? "Unknown topic"
        self.questions = nil
        self.numOfProblems = topic?["problems_count"] as? Int ?? -1
        self.numOfTheoryQuestions = topic?["theory_count"] as? Int ?? -1
        self.courseID = courseID
    }
}
