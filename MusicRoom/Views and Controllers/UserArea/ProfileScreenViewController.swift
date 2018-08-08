//
//  ProfileScreenViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/7/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

class ProfileScreenViewController: UIViewController {
    
    @IBOutlet weak var displayedEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEmailIntoProfile()
    }
    
    func getEmailIntoProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError("\nUser id could not be retrieved on the ProfileScreenViewController\n")
        }
        FirebaseManage.shared.retrieveUserInfo(uid: uid, { (snapshot) in
            if !snapshot.exists() { return }
            
            // Here the we extract a certain key out of the snapshot
            let keyValue = self.extractKeyValueFromSnapshot(key: "email", snapshot: snapshot)
            guard let email = keyValue else { return }
            self.displayedEmail.text = email
        })
    }
    
    func extractKeyValueFromSnapshot(key: String, snapshot: DataSnapshot) -> String? {
        for child in snapshot.children {
            if let elem = child as? DataSnapshot {
                if elem.key == "email" { return elem.value as? String }
            }
        }
        return nil
    }
}
