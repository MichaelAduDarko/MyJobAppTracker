//
//  ApplictaionsCell.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/29/21.
//

import Foundation

import UIKit
import Firebase

struct homeData {
    let _companyName: String?
    let _date : String?
    let _jobTitle: String?
    let _locationName: String?
    let _link: String?
}

protocol DataCollectionProtocol {
    func deleteData(indx: Int)
}

class ApplicationsCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let companyName: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 20, color: .mainBlueTintColor)
//        label.text = "Microsoft"
        return label
    }()
    
    private let date: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNextBold, fontSize: 16, color: .gray)
//        label.text = "November 30th 2021"
        return label
    }()
    
    //    private let dividerView = DividerView()
    
    private let jobPosition: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNextBold, fontSize: 16, color: .white)
//        label.text = "Jnr iOS Engineer"
        return label
    }()
    
    private let location: CustomLabel = {
        let label = CustomLabel(name: Font.Futura, fontSize: 16, color: .lightGray)
//        label.text = "New York"
        return label
    }()
    
    private let applicationURL: CustomLabel = {
        let label = CustomLabel(name: Font.AvenirNext, fontSize: 16, color: .blue)
        label.text = "https://ual-pro.taleo.net/careersection/10140/isi.ftl?job=EWR00003596&lang=en"
        //        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.tintColor = .systemRed
        return button
    }()
    
    
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        configureUI()
        buttonTargets()
        
        
       
    }
    
    //MARK:- Button Action
    
    private func buttonTargets(){
        
        inProgressButton.addTarget(self, action: #selector(handleInprogressButton), for: .touchUpInside)
        offerButton.addTarget(self, action: #selector(handleOfferButtonButton), for: .touchUpInside)
        rejectionButton.addTarget(self, action: #selector(handleRejectionButtonButton), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(handleDeleteButtonButton), for: .touchUpInside)
    }
    
    @objc func handleInprogressButton(){
        inProgressButton.flash()
        print("Button")
    }
    
    @objc func handleOfferButtonButton(){
        offerButton.flash()
        print("Button")
    }
    
    @objc func handleRejectionButtonButton(){
        rejectionButton.flash()
        print("Button")
    }
    
    
    @objc func handleDeleteButtonButton(){
        deleteButton.shake()
        delegate?.deleteData(indx: (index?.row)!)
    }
    
    
    var data: homeData? {
        didSet {
            guard  let data = data else {return}
            companyName.text = data._companyName
            date.text = data._date
            location.text = data._locationName
            jobPosition.text = data._jobTitle
            applicationURL.text = data._link
        }
    }
    
    func update(with item: Application) {
        companyName.text = item.companyName
        location.text = item.location
        jobPosition.text = item.jobTitle
        date.text = item.date
        applicationURL.text = item.applicationURL
       
    }
    
    
    //MARK:- Helpers
    
    private func configureUI(){
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
        
        let buttonStackView = UIStackView(arrangedSubviews: [inProgressButton,offerButton,rejectionButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing  = 72
        buttonStackView.distribution = .equalCentering
        
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: bottomStackView.bottomAnchor, left: leftAnchor,bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 40,paddingBottom:1 ,paddingRight: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
