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

        let tap = UITapGestureRecognizer(target: self, action: #selector(editEmailTap))
        emailAddress.isUserInteractionEnabled = true
        emailAddress.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FetchProfileInfo().getEmailIntoProfile { (email) in
            self.emailAddress.text = email
        }
    }
    
    @objc func editEmailTap(sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "presentEmailEdit", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
