//
//  FormSheetController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/23/21.
//

import UIKit

class FormSheetViewController: UIViewController {
    
    //MARK:- Properties
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setDimensions(height: 40, width: 40)
        button.imageView?.setDimensions(height: 26, width: 26)
        button.layer.cornerRadius = 40 / 2
        button.backgroundColor = .systemRed
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 2
        return button
    }()
    
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setDimensions(height: 40, width: 40)
        button.imageView?.setDimensions(height: 26, width: 26)
        button.layer.cornerRadius = 40 / 2
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 2
        
        return button
    }()
    
    private let titleLabel : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNextBold, fontSize: 25 , color: .backgroundColor)
        label.text = "Form"
        label.textAlignment = .natural
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK:- Selectors
    
    @objc func cancelButtonTapped(){
        dismiss(animated: true, completion: nil)
        print("dismiss view")
    }
    
    //MARK:- Button Actions
    
    private func buttonAction(){
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    //MARK:- Helpers
    private func configureUI(){
        buttonAction()
        view.backgroundColor = .white
        
        let topStack = UIStackView(arrangedSubviews: [cancelButton,UIView(),titleLabel,UIView(), doneButton])
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.axis = .horizontal
        topStack.isLayoutMarginsRelativeArrangement = true
        topStack.distribution = .equalCentering
        topStack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        view.addSubview(topStack)
        topStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,right: view.rightAnchor, paddingTop: -20)
    }
    
    
}
