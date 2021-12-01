//
//  HomeController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/26/21.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeController: UIViewController {
    
    lazy var data: [homeData] = dummyData._data
    
    //MARK:- Properties
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        cv.register(ApplicationsCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setDimensions(height: 40, width: 40)
        button.imageView?.setDimensions(height: 40, width: 40)
        button.layer.cornerRadius = 40 / 2
        button.backgroundColor = .gray
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        return button
    }()
    
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
    
    private let titleLabel: CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 20 , color: .black)
        label.text = "Applications"
        return label
    }()
    

    var items: [String] = {
        var items = [String]()
        for i in 1 ..< 20 {
            items.append("Item \(i)")
        }
        return items
    }()
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationController?.navigationBar.isHidden = true
        profileImageView.setDimensions(height: 135, width: 135)
        profileImageView.layer.cornerRadius = 135 / 2
        view.backgroundColor = .white
        
        backgroundView.addSubview(profileImageView)
        profileImageView.anchor(top: backgroundView.topAnchor, right: backgroundView.rightAnchor , paddingTop: -65, paddingRight: 10)
        
        view.addSubview(profileButton)
        profileButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: -25, paddingLeft: 10)
        
       
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 5,paddingRight: 5, width: 250, height: 150)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: backgroundView.bottomAnchor, left: view.leftAnchor,  paddingTop: 10, paddingLeft: 5)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        

        let stackView = UIStackView(arrangedSubviews: [candidateName, jobTitle])
        stackView.spacing = 10
        stackView.axis = .vertical
        
        backgroundView.addSubview(stackView)
        stackView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, right: profileImageView.leftAnchor, paddingTop: 10 , paddingLeft: 10, paddingRight: 10 )
        
        backgroundView.addSubview(dividerView)
        dividerView.anchor(top: stackView.bottomAnchor, left: backgroundView.leftAnchor,right: backgroundView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
        
        let statusCountStackView = UIStackView(arrangedSubviews: [inProgressCount,UIView(), offerCount, UIView(), rejectionCount])
        statusCountStackView.axis = .horizontal
        statusCountStackView.distribution = .equalCentering
        
        backgroundView.addSubview(statusCountStackView)
        statusCountStackView.anchor(top: stackView.bottomAnchor, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 10, paddingLeft: 10,  paddingRight: 10)
        
        
        let statusLabel = UIStackView(arrangedSubviews: [inProgress,UIView(), offer, UIView(), rejection])
        statusLabel.axis = .horizontal
        statusLabel.distribution = .equalCentering
        
        backgroundView.addSubview(statusLabel)
        statusLabel.anchor(top: statusCountStackView.bottomAnchor, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 5, paddingLeft: 10,  paddingRight: 10)
        
    }
}


//MARK:- Extensions

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return  data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ApplicationsCell
        cell.data = data[indexPath.row]
        cell.index = indexPath
        cell.delegate = self
        return cell
    }
}


extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 180)
    }
    
}


extension HomeController: DataCollectionProtocol {
    
    func deleteData(indx: Int) {
        data.remove(at: indx)
        collectionView.reloadData()
    }
}
