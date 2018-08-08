//
//  FetchProfileInfo.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/8/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation
import Firebase


// Responsible for fetching profile information into various screens
class FetchProfileInfo {
    
    
    func getEmailIntoProfile( _ completion: @escaping (_ email: String) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError("\nUser id could not be retrieved on the ProfileScreenViewController\n")
        }
        FirebaseManage.shared.retrieveUserInfo(uid: uid, { (snapshot) in
            if !snapshot.exists() { return }
            
            // Here the we extract a certain key out of the snapshot
            let keyValue = self.extractKeyValueFromSnapshot(key: "email", snapshot: snapshot)
            guard let email = keyValue else { return }
            completion(email)
        })
    }
    
    // this takes in a snapshot with several children and a key value
    // it will return the value of whatever key has been indicated.
    func extractKeyValueFromSnapshot(key: String, snapshot: DataSnapshot) -> String? {
        for child in snapshot.children {
            if let elem = child as? DataSnapshot {
                if elem.key == "email" { return elem.value as? String }
            }
        }
        return nil
    }
}
