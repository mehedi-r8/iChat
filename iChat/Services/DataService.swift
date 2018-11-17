//
//  DataService.swift
//  iChat
//
//  Created by MEHEDI.R8 on 11/13/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withgroupKey groupkey: String?, postComplete: @escaping (_ status: Bool) -> ()) {
        if groupkey != nil {
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            postComplete(true)
        }
    }
    
    func getAllFeedContent(handler: @escaping (_ message: [FeedContent]) -> ()) {
        REF_FEED.observeSingleEvent(of: .value) { (feedContentSnapshot) in
            var feedcontentArray = [FeedContent]()
            guard let feedContentSnapshot = feedContentSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for post in feedContentSnapshot {
                let content = post.childSnapshot(forPath: "content").value as! String
                let senderID = post.childSnapshot(forPath: "senderID").value as! String
                let feed = FeedContent(content: content, senderID: senderID)
                feedcontentArray.append(feed)
            }
            handler(feedcontentArray)
        }
     }
    
     func getUserEmail(forUid uid: String, handler: @escaping (_ username: String) -> ()) {
          REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
               guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
               for user in userSnapshot {
                    if user.key == uid {
                         handler(user.childSnapshot(forPath: "email").value as! String)
                    }
               }
          }
     }
}







