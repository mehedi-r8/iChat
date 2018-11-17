//
//  CreatePostVC.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/14/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var postTxtView: UITextView!
    @IBOutlet weak var postBtn: CustomButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTxtView.delegate = self
        postBtn.KeyboardBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        if postTxtView.text != nil && postTxtView.text != "Say Something ........." {
            DataService.instance.uploadPost(withMessage: postTxtView.text!, forUID: (Auth.auth().currentUser?.uid)!, withgroupKey: nil) { (isComplete) in
                if isComplete {
                    print("😘")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("error vau 😘😝")
                }
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTxtView.text = ""
    }
}
