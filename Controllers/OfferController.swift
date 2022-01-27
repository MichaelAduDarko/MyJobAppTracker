//
//  OfferController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/26/22.
//

import Foundation
import UIKit

private let reuseIdentifier = "cell"

class OfferController: UIViewController {
    
    
    //MARK:- Properties
    
    private let titlelabel: CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 28, color: .white)
        label.text = Constant.Offer
      return label
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = #colorLiteral(red: 0.1393083334, green: 0.1819166839, blue: 0.211665988, alpha: 1)
        cv.register(OfferCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad(){
        configureUI()
    }
    
    
    
    //MARK:- Selectors
    
    
    
    //MARK:- Helpers
    private func configureUI(){
        
        navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = #colorLiteral(red: 0.1393083334, green: 0.1819166839, blue: 0.211665988, alpha: 1)
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top:view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,paddingTop: 2, paddingLeft: 5)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: titlelabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 6,paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
}


//MARK:- Extensions
extension OfferController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OfferCell
       return cell
    }
    
}


extension OfferController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 168)
    }
    
}
