//
//  LRSVerification.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/30/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FacebookLogin

// Verification of the user auth state
extension LogRegController {
    
    func verifyUserAuthState () {
        if FBSDKAccessToken.current() != nil { getFBUserData() }
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                print("\nUser in verifyUserAuthState : ", (user?.email!)!) // TESTING
                
                print("\n\n\nUser inside of facebook verfify is : ", user) // TESTING
                guard let uid = user?.uid else { return }
                self.redirectToHomescreen(uid: uid)
            } else {
                print("\nUser is not logged in!\n")
            }
        }
    }
    
    // Checks if the user is already registered and if so
    // redirects him towards the homescreen
    func redirectToHomescreen(uid: String) {
        print("\nInside of the redirectHomeScreen function\n") // TESTING
        FirebaseManage.shared.isUserRegistered(uid: uid, completion: { (bool) in
            if bool == true { self.switchToHomeScreen() }
        })
    }
    
    func switchToHomeScreen() {
        print("\nInside of switchStoryboard\n") // TESTING
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeScreen")//instantiateViewController(withIdentifier: "HomeScreen") as UIViewController
        self.present(controller, animated: false, completion: nil)
    }
    
}
