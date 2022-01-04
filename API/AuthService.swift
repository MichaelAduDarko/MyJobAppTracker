//
//  AuthService.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/3/22.
//
import UIKit
import Firebase

struct RegistrationCredentials {
    let email: String
    let fullName: String
    let password: String
    let jobTitle: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?){
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3 ) else { return }
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            
            if let error = error {
                completion!(error)
                
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                
                Auth.auth().createUser(withEmail: credentials.email, password:  credentials.password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    
                    let data = [User.Keys.email: credentials.email,
                                User.Keys.fullName: credentials.fullName,
                                User.Keys.jobTitle: credentials.jobTitle,
                                User.Keys.profileImageURL: profileImageUrl,
                                User.Keys.identifier: uid] as [String : Any]
                    
                    COLLECTION_USERS.document(uid).setData(data, completion: completion)
        
                }
            }
        }
    }
    
    static func resetPassword(forEmail email: String, completion: (SendPasswordResetCallback?)){
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}

