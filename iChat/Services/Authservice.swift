//
//  Authservice.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/14/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                userCreationComplete(false, error)
                return
            }

            let userdata = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userdata as Dictionary<String, Any>)
            userCreationComplete(true, nil)
        }
    }
    
    func loginuser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard (authResult?.user) != nil else {
                loginComplete(false, error)
                return
            }
            
            loginComplete(true, nil)
        }
    }
}
