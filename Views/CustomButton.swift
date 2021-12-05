//
//  CustomButton.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/5/21.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.white, for: .normal)
        layer.shadowRadius = 15
        layer.borderWidth = 2
        layer.cornerRadius = 20
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.masksToBounds = false
        clipsToBounds = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        isEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

