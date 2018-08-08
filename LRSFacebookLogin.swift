//
//  LRSFacebookLogin.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/30/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FacebookLogin

extension LogRegController {
    
    // Facebook
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let result = result {
            self.authenticateOnFirebase()
            print("\nResult is", result) // TESTING
        }
    }
    // Facebook
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.present(HandleViews().switchScreen("StartScreen"), animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        print("\nInside of loginButtonDidLogOut\n") // TESTING
        print("\nInside of logout button in startscreen (Error)\n")
    }
    
    // The listener is needed because the profile won’t be completely populated at the moment the login completes. So effectively this code will wait around for the API to complete the profile, then will be called.
    func addListenerToFBProfile () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.FBSDKProfileDidChange, object: nil, queue: nil) { (Notification) in
            if let profile = FBSDKProfile.current(), let firstName = profile.firstName, let lastName = profile.lastName {
                print("\(firstName) ", "\(lastName)")
            } else {
                print("Unknown")
            }
        }
    }
    

    // gets the credential from fb and authenticaes with Firebase
    func authenticateOnFirebase() {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            self.promptForUserName(authResult: authResult)
        }
    }
    
    func promptForUserName (authResult: AuthDataResult?) {
        
        // check if user is registered
        FirebaseManage.shared.isUserRegistered(uid: authResult!.user.uid, completion: { (bool) in
            if bool == false {
                self.uid = authResult!.user.uid
                self.email = authResult!.user.email!
                //let userNode = UserNode(authResult!.user.uid, "email", authResult!.user.email!)
                print("\n\nUser is not registered\n\n") // TESTING
                //Switch to screen which will prompt for a username
                self.performSegue(withIdentifier: "promptForUserName", sender: self)
            } else {
                self.switchToHomeScreen()
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is UsernamePromptViewController
        {
            let vc = segue.destination as? UsernamePromptViewController
            vc?.uid = self.uid
            vc?.email = self.email
        }
    }

    // gets the user data and checks if the user
    // signing in is already registered.
    // If so it switches to the homescreen.
    func getFBUserData() {
        print("\nInside of getFBUserData\n") // TESTING
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil) {
                self.dict = result as! [String : AnyObject]
                
                
                guard let uid = self.dict["uid"] as? String else { return }
                print("\n\n\nTHE USER ID INSIDE OF GETFBUSERDATA:   :  ", uid) // TESTING
                self.redirectToHomescreen(uid: uid)
            }
            else {
                print("\nError inside of getFBUserData : ", error)
            }
        })
    }
    
    
}
