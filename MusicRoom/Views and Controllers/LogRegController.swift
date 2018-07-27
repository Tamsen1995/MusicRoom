//
//  ViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 6/28/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LogRegController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // checks if the user is logged in
        // presents home screen if so
        verifyUserAuthState()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}

// Verifies the user auth state
extension LogRegController {
    
    func verifyUserAuthState () {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                print("\nUser is logged in!!\n")
                self.switchStoryboard()
            } else {
                print("\nUser is not logged in!\n")
            }
        }
    }
    
    func switchStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeScreen") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
}

