//
//  RejectionCell.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 5/18/22.
//

import Firebase
import UIKit


class RejectionCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    private let companyName: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 20, color: .mainBlueTintColor)
        label.text = "Microsoft"
        return label
    }()
    
    private let date: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNextBold, fontSize: 16, color: .gray)
        label.text = "Jan 8, 2022"
        return label
    }()
    
    //    private let dividerView = DividerView()
    
    private let jobPosition: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNextBold, fontSize: 16, color: .white)
        label.text = "Jnr iOS Engineer"
        return label
    }()
    
    private let location: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 16, color: .lightGray)
        label.text = "New York"
        return label
    }()
    
    
    private let congratsMessage: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 20, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        label.text = "Better Luck Next Time "
        return label
    }()
    
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.tintColor = .systemRed
        return button
    }()
    
    func update(with item: Application, indexPath: IndexPath) {
        companyName.text = item.companyName
        location.text = item.location
        jobPosition.text = item.jobTitle
        date.text = item.date
    }
    
    //MARK:- LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame )
        
        buttonTargets()
        configureUI()
    }
    
    //MARK:- Button Action
    private func buttonTargets(){
        deleteButton.addTarget(self, action: #selector(handleDeleteButtonButton), for: .touchUpInside)
    }
    
    
    @objc func handleDeleteButtonButton(){
        print("Delete")
    }
    
    final private func configureUI(){
        
        backgroundColor = #colorLiteral(red: 0.06877002084, green: 0.08996887456, blue: 0.1052305398, alpha: 0.9835471854)
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 10
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        
        
        let topStackView = UIStackView(arrangedSubviews:[companyName,date, deleteButton])
        //        stackView.checkIfAutoLayOut()
        topStackView.axis = .horizontal
        topStackView.spacing = 50
        
        addSubview(topStackView)
        topStackView.anchor(top: topAnchor, left: leftAnchor,right: rightAnchor,
                            paddingTop: 18, paddingLeft: 8, paddingRight: 8)
        
        let bottomStackView = UIStackView(arrangedSubviews: [jobPosition, location])
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 4
        
        addSubview(bottomStackView)
        bottomStackView.anchor(top: topStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 8, paddingRight: 8)

        
        addSubview(congratsMessage)
        congratsMessage.centerX(inView: self, topAnchor: bottomStackView.bottomAnchor, paddingTop: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

