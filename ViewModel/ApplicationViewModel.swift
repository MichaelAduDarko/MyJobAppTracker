//
//  ApplicationViewModel.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 6/25/22.
//

import Foundation
import Combine

class ApplicationViewModel: ObservableObject {
    @Published var applications = [Application]()
    
    private let service: PostService
    
    init(service: PostService = PostService()) {
        self.service = service
    }
    
    func fetch(for userID: String, with state: Application.State) {
        PostService.fetchPost(for: userID, with: state) { result in
            self.applications = result
        }
    }
}
