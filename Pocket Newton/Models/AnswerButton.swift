//
//  AnswerButton.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 3/5/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {

    internal var isTheCorrectAnswer: Bool = false
    
    func set(text: String) {
        self.setTitle(text, for: .normal)
    }
}
