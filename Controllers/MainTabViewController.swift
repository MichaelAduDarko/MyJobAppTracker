//
//  MainViewController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/23/21.
//

import UIKit
import Firebase
import Lottie

class MainTabViewController: UITabBarController, UINavigationControllerDelegate  {
   
    
    //MARK:- Properties
    
    private let postItemButton: PostCustomButton = {
        let button = PostCustomButton()
        button.addTarget(self, action: #selector(handlepostItemButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserLoggedIn()

    }
    
    
    //MARK:- Selector
    
    @objc func handlepostItemButton(){
  
        let nav = UINavigationController(rootViewController: FormSheetViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        print("Button Tapped")
        
    }
    
    
    //MARK:- API
    
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK:- Helpers
    
    private func configureUI(){
        tabBar.isTranslucent = false
        tabBar.backgroundColor = #colorLiteral(red: 0.1393083334, green: 0.1819166839, blue: 0.211665988, alpha: 1)
        tabBar.tintColor = .white
        
    
        
        let home = HomeController()
        let nav1 = templateNavigationController(image: UIImage(systemName: "house"), rootviewController: home)
        nav1.title = "Home"

    

        let inProgress = InprogressController()
        let nav2 = templateNavigationController(image: UIImage(systemName: "hourglass.circle"), rootviewController: inProgress)
//        nav2.tabBarItem.badgeValue = "7"
        nav2.tabBarItem.badgeColor = .systemYellow
        nav2.title = "Inprogress"
 

        let offer = OfferController()
        let nav3 = templateNavigationController(image: UIImage(systemName: "hands.sparkles"), rootviewController: offer)
        nav3.title = "Offer"

        
        let rejection = OfferController()
        let nav4 = templateNavigationController(image: UIImage(systemName: "hand.thumbsdown"), rootviewController: rejection)
        nav4.title = "Rejection"
        
        viewControllers = [nav1, nav2, nav3, nav4]
        
        guard  let items = tabBar.items else { return}
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        }
        
        
        view.addSubview(postItemButton)
        postItemButton.anchor( bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,
                               paddingBottom: 64, paddingRight: 16)
        
    }


    
    func templateNavigationController(image: UIImage?, rootviewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootviewController)
    
        nav.tabBarItem.image = image
        nav.title = title
        return nav
    }
}
