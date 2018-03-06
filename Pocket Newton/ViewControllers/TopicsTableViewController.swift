//
//  TopicsTableViewController.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 2/21/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit
import Firebase

class TopicsTableViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak private var beginButton: UIBarButtonItem!
    
    // MARK: Class attributes
    internal var examType: ExamType!
    internal var courses: [Course] = [Course]()
    internal var selectedTopics: [Topic] = [Topic]()
    private var ref: DatabaseReference!
    
    // MARK: Class methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.ref = Database.database().reference()
        self.fetchCourses()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.courses.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses[section].topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.courses[indexPath.section].topics[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.courses[section].name
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTopic = self.courses[indexPath.section].topics[indexPath.row]
        self.selectedTopics.append(selectedTopic)
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedTopic = self.courses[indexPath.section].topics[indexPath.row]
        
        if let index = self.selectedTopics.index(where: {$0.id == selectedTopic.id}) {
            self.selectedTopics.remove(at: index)
        }
        
        if self.selectedTopics.count == 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BeginQuizSegue" {
            let quizVC = segue.destination as! QuizViewController
            quizVC.selectedTopics = self.selectedTopics
            quizVC.examType = self.examType
        }
    }
    
    // MARK: - Firebase
    
    /// Method that fetches all available courses from the database.
    private func fetchCourses() {
        // Obtain child "courses" from Firebase.
        self.ref.child("courses").observeSingleEvent(of: .value, with: { snapshot in
            // Temporary "courses" array.
            var courses: [Course] = [Course]()
            
            for item in snapshot.children {
                let course = Course(snapshot: item as! DataSnapshot)
                courses.append(course)
            }
            
            // Copy temporary array to class attribute and reload.
            self.courses = courses.sorted(by: {$0.name < $1.name})
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}
