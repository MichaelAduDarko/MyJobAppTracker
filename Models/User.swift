//
//  User.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/3/22.
//

import UIKit
import Firebase

struct User {
    let email: String
    let fullname: String
    let jobTitle: String
    let profileImageUrl: String
    let uid: String
    
    
    init(dictionary: [String:Any]) {
        
        self.email = dictionary[Keys.email] as? String ?? ""
        self.fullname = dictionary[Keys.fullName] as? String ?? ""
        self.jobTitle = dictionary[Keys.jobTitle] as? String ?? ""
        self.profileImageUrl = dictionary[Keys.profileImageURL] as? String ?? ""
        self.uid = dictionary[Keys.identifier] as? String ?? ""
        
    }
}

extension User {
    enum Keys {
        static let email = "email"
        static let fullName = "fullname"
        static let jobTitle = "jobTitle"
        static let profileImageURL = "profileImageUrl"
        static let identifier = "uid"
    }
}
