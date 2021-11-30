//
//  MainViewController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/23/21.
//

import UIKit

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
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    
        tabBar.backgroundColor = .systemGray6
    
        
        let home = HomeController()
        let nav1 = templateNavigationController(image: UIImage(systemName: "house.circle.fill"), rootviewController: home)
        nav1.title = "Home"
        
        let wish = HomeController()
        let nav6 = templateNavigationController(image: UIImage(systemName: "list.bullet.circle.fill"), rootviewController: wish)
        nav6.tabBarItem.badgeValue = "8"
        nav6.tabBarItem.badgeColor = .backgroundColor
        nav6.title = "WishList"
    

        let category = HomeController()
        let nav2 = templateNavigationController(image: UIImage(systemName: "hourglass.circle.fill"), rootviewController: category)
        nav2.tabBarItem.badgeValue = "7"
        nav2.tabBarItem.badgeColor = .systemYellow
        nav2.title = "Inprogress"
 

        let message = HomeController()
        let nav4 = templateNavigationController(image: UIImage(systemName: "hands.sparkles.fill"), rootviewController: message)
        nav4.tabBarItem.badgeValue = "4"
        nav4.tabBarItem.badgeColor = .systemGreen
        nav4.title = "Offer"

        
        let rejection = HomeController()
        let nav5 = templateNavigationController(image: UIImage(systemName: "hand.thumbsdown.fill"), rootviewController: rejection)
        nav5.tabBarItem.badgeValue = "50"
        nav5.tabBarItem.badgeColor = .systemPink
        nav5.title = "Rejection"

        //        let profile = ProfileController(style: .insetGrouped)
//        profile.delegate = self
//
//        let nav5 = templateNavigationController(image: UIImage(systemName: "person.fill"), rootviewController: profile)
//        nav5.title = "Profile"

        
        viewControllers = [nav1,nav6, nav2, nav4, nav5]
        
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
