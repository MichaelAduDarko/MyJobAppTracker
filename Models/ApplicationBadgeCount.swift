//
//  ApplicationBadgeCount.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 6/26/22.
//

import Foundation

class ApplicationBadgeCount {
    enum Keys {
        static let inpregressKey = "ApplicationBadgeCount.inprogress"
        static let offerKey = "ApplicationBadgeCount.offer"
        static let rejectionKey = "ApplicationBadgeCount.rejection"
    }
    
    static let shared = ApplicationBadgeCount()
    
    private let defaults = UserDefaults.standard
    private var applications = [Application]()
    private init () {
        self.inprogressCount = defaults.integer(forKey: Keys.inpregressKey)
        self.offerCount = defaults.integer(forKey: Keys.offerKey)
        self.rejectionCount = defaults.integer(forKey: Keys.rejectionKey)
    }
    
    private (set) var inprogressCount: Int
    private (set) var offerCount: Int
    private (set) var rejectionCount: Int
    
    func update(_ applications: [Application]) {
        self.applications = applications
        
        let inprogressCount = applications.filter { $0.state == .inProgress }.count
        self.inprogressCount = inprogressCount
        set(value: inprogressCount, for: Keys.inpregressKey)
        
        let offerCount = applications.filter { $0.state == .offer }.count
        self.offerCount = offerCount
        set(value: offerCount, for: Keys.offerKey)
        
        let rejectionCount = applications.filter { $0.state == .rejected }.count
        self.rejectionCount = rejectionCount
        set(value: rejectionCount, for: Keys.rejectionKey)
        
        NotificationCenter.default.post(name: .applicationUpdated, object: nil)
    }
    
    private func set(value: Int, for key: String) {
        defaults.set(value, forKey: key)
    }
}

extension Notification.Name {
    public static let applicationUpdated = Notification.Name("applicationUpdated")
}
