//
//  ApplictaionsCell.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/29/21.
//

import Foundation

import UIKit

class ApplicationsCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let companyName: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 19, color: .backgroundColor)
        label.text = "Microsoft"
        return label
    }()
    
    private let date: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNext, fontSize: 14, color: .gray)
        label.text = "November 30th 2021"
        return label
    }()
    
//    private let dividerView = DividerView()
    
    private let jobPosition: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNextBold, fontSize: 16, color: .backgroundColor)
        label.text = "Jnr iOS Engineer"
        return label
    }()
    
    private let location: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 16, color: .backgroundColor)
        label.text = "New York"
        return label
    }()
    
    private let applicationURL: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNext, fontSize: 16, color: .blue)
        label.text = "https://signon.ual.com/oamfed/idp/samlv20"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var inProgressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "hourglass"), for: .normal)
        button.setDimensions(height: 60, width: 60)
        button.tintColor = .systemYellow
        return button
    }()
    
    private lazy var offerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "hands.sparkles"), for: .normal)
        button.setDimensions(height: 60, width: 60)
        button.tintColor = .green
        return button
    }()
   
    
    private lazy var rejectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.setDimensions(height: 60, width: 60)
        button.tintColor = .systemPink
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame )
       configureUI()
        
    }
    
    private func configureUI(){
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 10
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        
        
        let topStackView = UIStackView(arrangedSubviews:[companyName,date])
//        stackView.checkIfAutoLayOut()
        topStackView.axis = .horizontal
        topStackView.spacing = 72
        
        addSubview(topStackView)
        topStackView.anchor(top: topAnchor, left: leftAnchor,
                            paddingTop: 18, paddingLeft: 8)
        
        let bottomStackView = UIStackView(arrangedSubviews: [jobPosition, location, applicationURL])
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 3
        
        addSubview(bottomStackView)
        bottomStackView.anchor(top: topStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 8)
        
        let buttonStackView = UIStackView(arrangedSubviews: [inProgressButton,offerButton,rejectionButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing  = 72
        buttonStackView.distribution = .equalCentering
        
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: bottomStackView.bottomAnchor, left: leftAnchor,bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 40,paddingBottom: 4,paddingRight: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
