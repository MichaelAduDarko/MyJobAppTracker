//
//  ImageUploader.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 1/3/22.
//

import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return}
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            
            if let error = error {
                print("DEBUG: Failed to uplaod image\(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
                
            }
        }
    }
}
