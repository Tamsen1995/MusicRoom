//
//  RegisterViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/2/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    FirebaseManage.shared.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        // TODO : Change this so it validates
        // the username and password before initializing
        let user = userData(emailTextField.text!, passwordTextField.text!)


        
        FirebaseManage.shared.createUserInDB(user)
        self.performSegue(withIdentifier: "registeredSegue", sender: self)
    }
    


}
