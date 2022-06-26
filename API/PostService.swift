//
//  PostService.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/5/22.
//

import Firebase
struct PostService {
    
    static let shared = PostService()
    
    static func uploadItem(jobTitle: String, date: String, companyName: String, location: String,applicationURL:String,completion: @escaping(Error?) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let state = Application.State.submitted
        let values = [
            "uid":uid,
            "jobTitle": jobTitle,
            "date": date,
            "companyName": companyName,
            "url": applicationURL,
            "location": location,
            "state": state.rawValue
        ] as [String : Any]
            
        REF_POSTITEM.addDocument(data: values, completion: completion)
        
    }
    
    static func fetchPost(for userID: String, with state: Application.State, completion: @escaping([Application]) -> Void){
        REF_POSTITEM.whereField("uid", isEqualTo: userID).getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({Application(postItemID: $0.documentID, dictionary: $0.data())}).filter { $0.state == state } 
            completion(posts)
        }
        
    }
    
    static func delete(application: Application, completion: @escaping(Bool) -> Void) {
        REF_POSTITEM.document(application.postItemID).delete { error in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    static func update(using param: UpdateParams, completion: @escaping (Bool) -> Void) {
        REF_POSTITEM
            .document(param.identifier)
            .setData(["state": param.state.rawValue],
                     merge: true) { result in
            completion(result == nil)
        }
    }
}

struct UpdateParams {
    let identifier: String
    let indexPath: IndexPath
    let state: Application.State
}
