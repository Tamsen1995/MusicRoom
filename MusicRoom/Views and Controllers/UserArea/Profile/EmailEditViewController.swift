//
//  EmailEditViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/8/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

class EmailEditViewController: UIViewController {
    
    @IBOutlet weak var modifiedEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitNewEmail(_ sender: Any) {
        if let newEmail = modifiedEmail.text {
            guard let uid = Auth.auth().currentUser?.uid else { fatalError("\nCurrent user id could not be extracted\n") }
            FirebaseManage.shared.createUserNodeInDb(UserNode(uid, "email", newEmail))
        }
    }
    
}
