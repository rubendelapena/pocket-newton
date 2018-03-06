//
//  ExamTypeViewController.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 2/21/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit

class ExamTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TheorySegue" {
            let topicsTVC = segue.destination as! TopicsTableViewController
            topicsTVC.examType = .theory
        } else if segue.identifier == "ProblemsSegue" {
            let topicsTVC = segue.destination as! TopicsTableViewController
            topicsTVC.examType = .problems
        }
    }
}
