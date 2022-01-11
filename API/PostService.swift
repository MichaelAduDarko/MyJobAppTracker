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
        
            
            let values = [
                          "uid":uid,
                          "jobTitle": jobTitle,
                          "date": date,
                          "companyName": companyName,
                          "url": applicationURL,
                          "location": location ] as [String : Any]
            
        REF_POSTITEM.addDocument(data: values, completion: completion)
        
    }
    
    static func fetchPost(completion: @escaping([Item]) -> Void){
        REF_POSTITEM.getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({Item(postItemID: $0.documentID, dictionary: $0.data())})
            completion(posts)
            
            
        }
        
    }
    
}
