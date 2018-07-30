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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        // checks if the user is logged in
        // presents home screen if so
        verifyUserAuthState()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let token = result?.token?.tokenString {
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                
                Auth.auth().currentUser!.link(with: credential) { (user, error) in
                    if user != nil && error == nil {
                        DispatchQueue.global(qos: .userInitiated).async {
                            print("\n\n\ncredentials are : ", credential) // TESTING
                        }
                        // Success
                    } else {
                        print("linkWithCredential error: ", error)
                    }
                }
            }
        }
        
        print("\nInside of loginButton\n") // TESTING
        if let result = result {
            print("\nResult is", result) // TESTING
            //            self.userIdLabel.text = result.token.userID
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("\nInside of loginButtonDidLogOut\n") // TESTING
    }
    
    // The listener is needed because the profile won’t be completely populated at the moment the login completes. So effectively this code will wait around for the API to complete the profile, then will be called.
    func addListenerToFBProfile () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.FBSDKProfileDidChange, object: nil, queue: nil) { (Notification) in
            if let profile = FBSDKProfile.current(), let firstName = profile.firstName, let lastName = profile.lastName {
                print("\(firstName)")
            } else {
                print("Unknown")
            }
        }
    }
    
    @IBAction func signIn(_ sender: GIDSignInButton) {
        print("\nInside of signIn\n") // TESTING
        GIDSignIn.sharedInstance().signIn()
    }
}

// Verifies the user auth state
extension LogRegController {
    
    func verifyUserAuthState () {
        
        if let accessToken = FBSDKAccessToken.current() {
            print("\n\n\nHello?!!?\n\n\n") // TESSTING
            getFBUserData()
        }
        
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
        print("\nInside of switchStoryboard\n") // TESTING
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeScreen") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    //function is fetching the user data
    func getFBUserData() {
        print("\nInside of getFBUserData\n") // TESTING
        if ((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    self.dict = result as! [String : AnyObject]
                    print("--> ", result!)
                    self.switchStoryboard()
                    print(self.dict)
                }
                else {
                    print("\nThe error found is : -> ", error) // TESTING
                }
            })
        }
    }
}

