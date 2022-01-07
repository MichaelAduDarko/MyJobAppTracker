//
//  ProfileViewModel.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/4/22.
//

import Foundation

struct ProfileViewModel {
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    
    var jobTitle: String {
        return user.jobTitle
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
