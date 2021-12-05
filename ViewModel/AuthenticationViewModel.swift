//
//  AuthenticationViewModel.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/5/21.
//

import Foundation

protocol AuthenticationViewModel {
    var  formIsValid: Bool { get}
    
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
}


struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var fullname: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            fullname?.isEmpty == false
    }
}


struct ResetPasswordViewModel: AuthenticationViewModel {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
}
