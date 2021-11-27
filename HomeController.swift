//
//  HomeController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/26/21.
//

import UIKit

class HomeController: UIViewController{
    
    //MARK:- Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "Mikke")
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 8
        return iv
    }()
    
    private let candidateName : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 20 , color: .white)
        label.text = "Michael Adu Darko "
        return label
    }()
    
    private let jobTitle : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNext, fontSize: 18 , color: .white)
        label.text = "iOS Developer"
        return label
    }()
    
    private let dividerView = DividerView()
    
    private let wishListCount : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 25 , color: .backgroundColor)
        label.text = "8"
        return label
    }()
    
    private let wishList : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNextBold, fontSize: 15 , color: .systemGray4)
        label.text = "Wishlist"
        return label
    }()
    
    private let inProgressCount : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 25 , color: .systemYellow)
        label.text = "7"
        return label
    }()
    
    private let inProgress : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNextBold, fontSize: 15 , color: .systemGray4)
        label.text = "Inprogress"
        return label
    }()
    
    private let offerCount : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 25 , color: .systemGreen)
        label.text = "4"
        return label
    }()
    
    private let offer : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNextBold, fontSize: 15 , color: .systemGray4)
        label.text = "Offer"
        return label
    }()
    
    private let rejectionCount : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 25 , color: .systemPink)
        label.text = "50"
        return label
    }()
    
    private let rejection : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNextBold, fontSize: 15 , color: .systemGray4)
        label.text = "Rejection"
        return label
    }()
    

    private let backgroundView = Customview(color: .mainBlueTintColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
    }
    
    
    //MARK:- Selector
    
    @objc func handlepostItemButton(){
  
        let nav = UINavigationController(rootViewController: FormSheetViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        print("Button Tapped")
        
    }

    //MARK:- Helpers
    
    private func configureUI(){
        navigationController?.navigationBar.isHidden = true
        profileImageView.setDimensions(height: 135, width: 135)
        profileImageView.layer.cornerRadius = 135 / 2
        view.backgroundColor = .white
        
        backgroundView.addSubview(profileImageView)
        profileImageView.anchor(top: backgroundView.topAnchor, right: backgroundView.rightAnchor , paddingTop: -65, paddingRight: 10)
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 5,paddingRight: 5, width: 250, height: 150)

        let stackView = UIStackView(arrangedSubviews: [candidateName, jobTitle])
        stackView.spacing = 10
        stackView.axis = .vertical
        
        backgroundView.addSubview(stackView)
        stackView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, right: profileImageView.leftAnchor, paddingTop: 10 , paddingLeft: 10, paddingRight: 10 )
        
        backgroundView.addSubview(dividerView)
        dividerView.anchor(top: stackView.bottomAnchor, left: backgroundView.leftAnchor,right: backgroundView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
        
        let statusCountStackView = UIStackView(arrangedSubviews: [wishListCount,UIView(),inProgressCount,UIView(), offerCount, UIView(), rejectionCount])
        statusCountStackView.axis = .horizontal
        statusCountStackView.distribution = .equalCentering
        
        backgroundView.addSubview(statusCountStackView)
        statusCountStackView.anchor(top: stackView.bottomAnchor, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 10, paddingLeft: 10,  paddingRight: 10)
        
        
        let statusLabel = UIStackView(arrangedSubviews: [wishList,UIView(),inProgress,UIView(), offer, UIView(), rejection])
        statusLabel.axis = .horizontal
        statusLabel.distribution = .equalCentering
        
        backgroundView.addSubview(statusLabel)
        statusLabel.anchor(top: statusCountStackView.bottomAnchor, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 5, paddingLeft: 10,  paddingRight: 10)

    }
}
