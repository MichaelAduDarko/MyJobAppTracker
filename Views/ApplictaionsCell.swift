//
//  ApplictaionsCell.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/29/21.
//

import Foundation

import UIKit

class ApplicationsCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 10
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
