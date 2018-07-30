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
import FBSDKLoginKit
import FacebookLogin

class LogRegController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    var dict : [String : AnyObject]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Everytime the view appears
        // we check if the user is logged in or not
        verifyUserAuthState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Facebook
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        // Google
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
    }
    
    

}

