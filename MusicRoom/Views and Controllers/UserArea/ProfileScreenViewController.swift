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
        
        // Do any additional setup after loading the view.
    }
    
    
    func getEmailIntoProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError("\nUser id could not be retrieved on the ProfileScreenViewController\n")
        }
        FirebaseManage.shared.retrieveUserInfo(uid: uid, { (snapshot) in
            if !snapshot.exists() { return }

            for elem in snapshot.children {
                print(elem) // TESTING
                // Need to figure out how to handle the data snapshot
            }
            
//            print(snapshot.children)
//                if let email = snapshot.ch as? String {
//                    print("\nEmail is good\n", email)
//                }
            
        })
    }
    
    
    
    
    
}
