//
//  Course.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 2/21/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import Foundation
import Firebase

class Course {
    internal var id: String
    internal var name: String
    internal var topics: [Topic]
    
    public init(snapshot: DataSnapshot) {
        let course = snapshot.value as? NSDictionary
        
        self.id = snapshot.key
        self.name = course?["name"] as? String ?? "Unknown course"
        
        let topicsSnapshot = snapshot.childSnapshot(forPath: "topics")
        var topics: [Topic] = [Topic]()
        for item in topicsSnapshot.children {
            let topic = Topic(snapshot: item as! DataSnapshot)
            topics.append(topic)
        }
        
        self.topics = topics.sorted(by: {$0.name < $1.name})
    }
    
    public init(id: String, name: String, topics: [Topic]) {
        self.id = id
        self.name = name
        self.topics = topics
    }
}
