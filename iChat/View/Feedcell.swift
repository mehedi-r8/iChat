//
//  Feedcell.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/14/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit

class Feedcell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImg.image = profileImage
        self.emailLbl.text = email
        self.messageLbl.text = content
    }
}
