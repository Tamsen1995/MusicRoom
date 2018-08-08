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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FetchProfileInfo().getEmailIntoProfile { (email) in
            self.displayedEmail.text = email
        }
    }
        
    
    
    
    
    
}
