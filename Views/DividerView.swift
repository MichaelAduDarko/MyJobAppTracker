//
//  DividerView.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/25/21.
//

import UIKit


class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let divider = UIView()
        divider.backgroundColor = UIColor(white: 1, alpha: 0.25)
        addSubview(divider)
        divider.centerY(inView: self)
        divider.anchor(left: leftAnchor, right: rightAnchor,
                          paddingLeft: 8, paddingRight: 8, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
