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
    @IBOutlet weak var passwordVerify: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    FirebaseManage.shared.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func passwordVerify(_ password: String, _ password2: String) -> Bool {
        return password == password2
    }
    
    
    // check if a string is nil or empty, returns unwrapped string
    func checkString(_ string: String?) -> String {
        guard let ret = string else { return "" }
        if ret.isEmpty == true { return "" }
        return string!
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        var user = userData("", "")
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////// verification of inputs
         let email = checkString(emailTextField.text)
         let password = checkString(passwordTextField.text)
         let password2 = checkString(passwordVerify.text)
         
        if email.isEmpty || password.isEmpty || password2.isEmpty {
            print("\nPlease fill out all the fields\n")
            return
        }
        
        
        
        if (passwordVerify(password, password2) == true) {
            user = userData(email, password)
        } else {
            // TODO : Make it so a prompt says if the passwords are equal or not
            print("\nYour first passwords do not match\n") // TESTING
            return
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        

        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "localhost")
        // The sign-in operation has to always be completed in the app
        actionCodeSettings.handleCodeInApp = false
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        actionCodeSettings.setAndroidPackageName("com.example.androids", installIfNotAvailable: false, minimumVersion: "12")
        


        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { (error) in
            if let error = error {
                print("\n\n\nThere was an error while sending the link in registerPressed", error) // TESTING
                return
            }
            // No error means the link was successfully sent
            UserDefaults.standard.set(email, forKey: "Email")
            print("\nCheck your email for a link pleaase\n") // TESTING
        }
        
        
        if let user = Auth.auth().currentUser {
            print("\nUser is ", user) // TESTING
        }
        
        
    //    FirebaseManage.shared.createUserInDB(user)
        //self.performSegue(withIdentifier: "registeredSegue", sender: self)
    }
    


}
