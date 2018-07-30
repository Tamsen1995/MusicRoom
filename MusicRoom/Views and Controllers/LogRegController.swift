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
//    @IBOutlet weak var userIdLabel: UILabel!
//    @IBOutlet weak var userNameLabel: UILabel!
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("\nInside of loginButton\n") // TESTING
        if let result = result {
            print("\nResult is", result) // TESTING
//            self.userIdLabel.text = result.token.userID
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("\nInside of loginButtonDidLogOut\n") // TESTING
    }
    
    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        

        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.FBSDKProfileDidChange, object: nil, queue: nil) { (Notification) in
            if let profile = FBSDKProfile.current(), let firstName = profile.firstName, let lastName = profile.lastName {
                print("\(firstName)") // TESTING
//                self.userNameLabel.text = "\(firstName)"
            } else {
                print("Unknown") // TESTING
//                self.userNameLabel.text = "Unknown"
            }
        }
        
//
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        view.addSubview(loginButton)
//
        
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current() {
            getFBUserData()
        }
        // checks if the user is logged in
        // presents home screen if so
        verifyUserAuthState()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    

    
    //function is fetching the user data
    func getFBUserData() {
        print("\nInside of getFBUserData\n") // TESTING
        if ((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    self.dict = result as! [String : AnyObject]
                    print("--> ", result!)
                    print(self.dict)
                }
                else {
                    print("\nThe error found is : -> ", error) // TESTING
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

