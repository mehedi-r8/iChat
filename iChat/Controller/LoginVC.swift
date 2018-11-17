
//
//  LoginVC.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/14/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxtField: CustomTextFieldView!
    @IBOutlet weak var passwordtxtField: CustomTextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailTxtField.text != nil && passwordtxtField != nil {
            AuthService.instance.loginuser(withEmail: emailTxtField.text!, andPassword: passwordtxtField.text!, loginComplete: {(success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(loginError?.localizedDescription as Any)
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordtxtField.text!, userCreationComplete: { (success, registerUserError) in
                    if success {
                        AuthService.instance.loginuser(withEmail: self.emailTxtField.text!, andPassword: self.passwordtxtField.text!, loginComplete: {(success, loginError) in
                            self.dismiss(animated: true, completion: nil)
                            print("🏄‍♂️")
                        })
                    } else {
                        print(registerUserError?.localizedDescription as Any)
                    }
                })
            })
        }
    }
}
