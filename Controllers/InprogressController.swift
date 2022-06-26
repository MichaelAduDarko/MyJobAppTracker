//
//  InprogressController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/26/22.
//

import Foundation
import UIKit
import Firebase
import Combine

private let reuseIdentifier = "cell"

class InprogressController: UIViewController {
    
    private var cancellable: AnyCancellable?
    private var inprogress = [Application]()
    private let viewModel: ApplicationViewModel
    
    init(viewModel: ApplicationViewModel = ApplicationViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Properties
    
    private let titlelabel: CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 28, color: .white)
        label.text = Constant.Inprogress
      return label
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = #colorLiteral(red: 0.1393083334, green: 0.1819166839, blue: 0.211665988, alpha: 1)
        cv.register(InprogressCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad(){
        configureUI()
        bindState()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        viewModel.fetch(for: userID, with: .inProgress)
    }
    
    private func bindState() {
        cancellable = viewModel.$applications
            .dropFirst()
            .sink { result in
                self.inprogress = result
                self.collectionView.reloadData()
            }
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
        collectionView.anchor(top: titlelabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 2,paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
}


//MARK:- Extensions
extension InprogressController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inprogress.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InprogressCell
        let aplication = inprogress[indexPath.row]
        cell.update(with: aplication, indexPath: indexPath)
       return cell
    }
    
}


extension InprogressController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 168)
    }
    
}
