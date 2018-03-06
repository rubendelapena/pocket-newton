//
//  QuestionNoMediaView.swift
//  Pocket Newton
//
//  Created by Ruben de la Pena on 3/4/18.
//  Copyright © 2018 Rubén de la Peña. All rights reserved.
//

import UIKit

class QuestionNoMediaView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    internal var parent: QuizViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("QuestionNoMedia", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
