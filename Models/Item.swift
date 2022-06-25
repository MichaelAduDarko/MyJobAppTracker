//
//  Item.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/5/22.
//

import Foundation

struct Application {
    let uid: String
    let postItemID: String
    let companyName: String
    let jobTitle: String
    let date: String
    let location: String
    let applicationURL: String
    let state: State
    
    init(postItemID: String, dictionary: [String: Any]) {
        
        self.postItemID = postItemID
        self.uid = dictionary ["uid"] as? String ?? ""
        self.companyName = dictionary ["companyName"] as? String ?? ""
        self.jobTitle = dictionary ["jobTitle"] as? String ?? ""
        self.date = dictionary ["date"] as? String ?? ""
        self.location = dictionary ["location"] as? String ?? ""
        self.applicationURL = dictionary ["url"] as? String ?? ""
        let stateValue = dictionary["state"] as? String ?? ""
        self.state = State(rawValue: stateValue) ?? .none
    }
}

extension Application {
    init(companyName: String, jobTitle: String, date: String, location: String, applicationURL: String, state: State) {
        self.companyName = companyName
        self.jobTitle = jobTitle
        self.date = date
        self.location = location
        self.applicationURL = applicationURL
        self.postItemID = UUID().uuidString.lowercased()
        self.uid = UUID().uuidString.lowercased()
        self.state = state
    }
}

// MARK: Application State
extension Application {
    enum State: String {
        case submitted
        case inProgress
        case offer
        case rejected
        case none
    }
}
