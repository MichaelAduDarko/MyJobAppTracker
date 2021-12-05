//
//  CustomtextField.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/5/21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, autoCorrectionType: UITextAutocorrectionType = .default, secureTextEntry:Bool) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 12).isActive = true
        leftView = spacer
        leftViewMode = .always
        layer.cornerRadius = 15.0
        layer.shadowRadius = 15
        layer.borderWidth = 3
        layer.masksToBounds = true
        borderStyle = .none
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = .white
        isSecureTextEntry = secureTextEntry
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 1.9)])
        autocorrectionType = autoCorrectionType
        textContentType = .oneTimeCode
        
        checkIfAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


