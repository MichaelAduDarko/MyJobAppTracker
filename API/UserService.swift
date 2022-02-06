//
//  UserService.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/3/22.
//

import Firebase

class UserManager {
    static let shared = UserManager()
    
    private var _user: [String: User] = [:]
    private init() {}
    
    func setCurrentUser(using identifier: String, user: User) {
        _user[identifier] = user
    }
    
    func user(with identifier: String) -> User? {
        return _user[identifier]
    }
    
    func cleanup() {
        _user = [:]
    }
}

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        if let _user = UserManager.shared.user(with: uid) {
            completion(_user)
            return
        }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error  in
            
            guard let dictionary = snapshot?.data() else { return }
        
            let user = User(dictionary: dictionary)
            UserManager.shared.setCurrentUser(using: uid, user: user)
            completion(user)
            
        }
    }
}
