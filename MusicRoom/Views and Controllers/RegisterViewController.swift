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
    
    // This is for the setting of a verification link in case we need it in the future
    //    func setActionCodeSettings() -> ActionCodeSettings {
    //        let actionCodeSettings = ActionCodeSettings()
    //        actionCodeSettings.url = URL(string: "musicroom-1250a.firebaseapp.com")
    //        // The sign-in operation has to always be completed in the app
    //        actionCodeSettings.handleCodeInApp = true
    //        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
    //        return actionCodeSettings
    //    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        var user = signUpInfo("", "")
        let email = checkString(emailTextField.text)
        let password = checkString(passwordTextField.text)
        let password2 = checkString(passwordVerify.text)
        
        if email.isEmpty || password.isEmpty || password2.isEmpty {
            print("\nPlease fill out all the fields\n")
            return
        }
        if (passwordVerify(password, password2) == true) {
            user = signUpInfo(email, password)
        } else {
            // TODO : Make it so a prompt says if the passwords are equal or not
            print("\nYour first passwords do not match\n") // TESTING
            return
        }
        FirebaseManage.shared.createUserInAuth(user)
        self.present(HandleViews().switchScreen("HomeScreen"), animated: true, completion: nil)
    }
    
    
    
}
