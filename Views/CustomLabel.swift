//
//  CustomLabel.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/23/21.
//

import UIKit

class CustomLabel: UILabel {
    
    
    init( name fontName: String, fontSize: CGFloat, color: UIColor) {
        super.init(frame: .zero)
            
//         text = title
         font = UIFont(name: fontName, size: fontSize)
         numberOfLines = 0
         textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
