//
//  CustomView.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/25/21.
//

import UIKit

class Customview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    init(color:UIColor = .white) {
        super.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = 24
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
