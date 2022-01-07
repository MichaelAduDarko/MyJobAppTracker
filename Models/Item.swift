//
//  Item.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/5/22.
//

import Foundation

struct Item {
    let uid: String
    let postItemID: String
    let companyName: String
    let jobTitle: String
    let date: String
    let location: String
    let applicationURL: String
    
    init(postItemID: String, dictionary: [String: Any]) {
        
        self.postItemID = postItemID
        self.uid = dictionary ["uid"] as? String ?? ""
        self.companyName = dictionary ["companyName"] as? String ?? ""
        self.jobTitle = dictionary ["jobTitle"] as? String ?? ""
        self.date = dictionary ["date"] as? String ?? ""
        self.location = dictionary ["location"] as? String ?? ""
        self.applicationURL = dictionary ["url"] as? String ?? ""
    }
}
