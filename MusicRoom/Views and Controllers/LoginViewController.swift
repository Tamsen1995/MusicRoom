//
//  LoginViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/7/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailAddress.text else { return }
        guard let password = password.text else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("\nThere was an error inside the loginButtonPressed function : ", error)
            } else {
                self.present(HandleViews().switchScreen("HomeScreen"), animated: true, completion: nil)
            }
            // ...
        }
        // simply put the
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
