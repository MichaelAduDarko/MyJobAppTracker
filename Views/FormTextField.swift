//
//  FormTextField.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/2/21.
//

import UIKit
class FormTextField: UITextField {
    
    init(placeHolder: String) {
        
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        layer.cornerRadius = 15.0
        layer.shadowRadius = 15
        layer.borderWidth = 3
        layer.masksToBounds = true
        borderStyle = .none
        layer.borderColor = #colorLiteral(red: 0.2213829578, green: 0.6727860964, blue: 0.9729384217, alpha: 1)
        textColor = .white
        autocorrectionType = .no
        
        backgroundColor = .lightGray
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 1.9)])
        
        checkIfAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
