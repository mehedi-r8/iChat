//
//  FeedContent.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/14/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import Foundation

class FeedContent {
    private var _cntent: String
    private var _senderID: String
    
    var content: String {
        return _cntent
    }
    
    var senderID: String {
        return _senderID
    }
    
    init(content: String, senderID: String ) {
        self._cntent = content
        self._senderID = senderID
    }
}
