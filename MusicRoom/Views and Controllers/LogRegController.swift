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

class LogRegController: UIViewController, GIDSignInUIDelegate {
    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        // checks if the user is logged in
        // presents home screen if so
        verifyUserAuthState()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    /////////////////////////// when the fb button is clicked
    //when login button clicked
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print("--> ", result!)
                    print(self.dict)
                }
            })
        }
    }
    
    
    
    ////////////
    
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

