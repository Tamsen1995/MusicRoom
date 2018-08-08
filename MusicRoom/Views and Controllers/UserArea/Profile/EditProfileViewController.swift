//
//  EditProfileViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/8/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var emailAddress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        FetchProfileInfo().getEmailIntoProfile { (email) in
            self.emailAddress.text = email
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(editEmailTap))
        emailAddress.isUserInteractionEnabled = true
        emailAddress.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func editEmailTap(sender: UITapGestureRecognizer) {
        print("tap working")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
