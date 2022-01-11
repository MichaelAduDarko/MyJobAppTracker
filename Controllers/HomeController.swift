//
//  HomeController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/26/21.
//

import UIKit
import Lottie
import Firebase
import SDWebImage

private let reuseIdentifier = "cell"

class HomeController: UIViewController {
    
    private var posts = [Item]()
    
    
    var users : User? {
        didSet { populateUserData()}
    }
    
    //MARK:- Properties
    
    private let animationView = AnimationView()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        cv.register(ApplicationsCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setDimensions(height: 50, width: 50)
        button.imageView?.setDimensions(height: 40, width: 40)
        button.layer.cornerRadius = 50 / 2
        button.backgroundColor = .systemRed
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 1
        button.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
//        iv.image = #imageLiteral(resourceName: "Mikke")
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 8
        return iv
    }()
    
    private let candidateName : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 20 , color: .white)
//        label.text = "Michael Adu Darko "
        return label
    }()
    
    private let jobTitle : CustomLabel = {
        let label =  CustomLabel( name: Font.AvenirNext, fontSize: 18 , color: .white)
//        label.text = "iOS Developer"
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
        populateUserData()
        configureUI()
  
       postUserData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //MARK:- Selector
    
    @objc func handlepostItemButton(){
        
        let nav = UINavigationController(rootViewController: FormSheetViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        print("Button Tapped")
        
    }
    
    
    @objc func handleLogOut(){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async { SceneDelegate.routeToRootViewController() }
        }  catch {
            
        }
        
    }
    
    //MARK:- Selectors
    @objc func handleRefresher(){
        posts.removeAll()
        postUserData()
    }
    
    //MARK: - API
    func populateUserData(){
        
        UserService.fetchUser { user in
            DispatchQueue.main.async {
                self.users  = user
                self.candidateName.text = user.fullname
                self.jobTitle.text = user.jobTitle

                let url = URL(string: user.profileImageUrl)
                self.profileImageView.sd_setImage(with: url)
            }
        }
     
    }
    
    //MARK:- API
    
    func postUserData(){
        PostService.fetchPost { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
        
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
        
        
        
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 5,paddingRight: 5, width: 250, height: 150)
        
        view.addSubview(logOutButton)
        logOutButton.anchor(top: view.safeAreaLayoutGuide.topAnchor , left: view.leftAnchor, paddingLeft: 5)
        
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
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresher), for: .valueChanged)
        collectionView.refreshControl = refresher
        
        collectionView.alpha = 0
        profileImageView.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.collectionView.alpha = 1
            self.profileImageView.alpha = 1
        }
        
    }
}


//MARK:- Extensions

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if posts.count == 0 {
            collectionView.setEmptyMessage()
        } else {
            collectionView.restore()
        }
        return  posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ApplicationsCell
        let item = posts[indexPath.row]
        cell.update(with: item)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryDetail = ApplicationDetailsController()
        self.navigationController?.pushViewController(categoryDetail, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 168)
    }
    
}


extension HomeController: DataCollectionProtocol {
    
    func deleteData(indx: Int) {
        items.remove(at: indx)
        collectionView.reloadData()
    }
}

//MRAK:- PlaceHolder for Empty CollectionView
extension UICollectionView {
    
    func setEmptyMessage() {
        let messageLabel = AnimationView()
        messageLabel.animation = Animation.named(LottieAnimation.emptyState)
        messageLabel.loopMode = .loop
        messageLabel.contentMode = .scaleAspectFit
        messageLabel.animationSpeed = 0.5
        messageLabel.play()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
