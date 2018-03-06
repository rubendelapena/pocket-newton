//
//  QuizViewController.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 3/4/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit
import Firebase

class QuizViewController: UIViewController {

    internal var questions: [Question] = [Question]()
    internal var selectedTopics: [Topic]!
    internal var examType: ExamType!
    private var ref: DatabaseReference!
    
    private var currentQuestionNum: Int = -1
    private let minNumOfQuestionsPerTopic: Int = 3
    private var question: Question {
        return self.questions[self.currentQuestionNum]
    }
    
    @IBOutlet weak private var auxView: UIView!
    private var activeView: UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        self.fetchQuestions()
        
        self.auxView.isHidden = true
        self.showReadyFor(question: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
    }
    
    private func showReadyFor(question: Int) {
        let readyQuiz = ReadyQuizView(frame: self.auxView.frame)
        readyQuiz.questionNumber.text = "Question " + String(question)
        readyQuiz.parent = self
        
        self.view.addSubview(readyQuiz)
        self.activeView = readyQuiz
    }
    
    // MARK: - Firebase
    
    /// Method that fetches the questions from the database.
    private func fetchQuestions() {
        for topic in selectedTopics {
            fetchQuestionsFor(topic: topic)
            self.questions = self.questions.shuffled
        }
    }
    
    private func fetchQuestionsFor(topic: Topic) {
        let path = "topics/\(topic.courseID)/\(topic.id)/questions/\(self.examType!)"
        
        self.ref.child(path).observeSingleEvent(of: .value, with: { snapshot in
            // Temporary "questions" array.
            var questions: [Question] = [Question]()
            
            for item in snapshot.children {
                let question = Question(snapshot: item as! DataSnapshot, topicID: topic.id)
                questions.append(question)
            }
            
            // Copy temporary array to class attribute.
            self.questions.append(contentsOf: questions.shuffled.prefix(self.minNumOfQuestionsPerTopic))
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

extension QuizViewController: QuizDelegate {
    func beginNextQuestion() {
        self.currentQuestionNum = self.currentQuestionNum + 1
        
        if self.question.type == .noMedia {
            let questionView = QuestionNoMediaView(frame: self.auxView.frame, question: self.question)
            questionView.parent = self
            
            self.view.addSubview(questionView)
            self.activeView = questionView
        } else {
            let questionView = QuestionWithImageView(frame: self.auxView.frame)
            questionView.parent = self
            
            self.view.addSubview(questionView)
            self.activeView = questionView
        }
    }
}
