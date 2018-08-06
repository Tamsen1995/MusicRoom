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
                print("\nUser in verifyUserAuthState : ", (user?.email!)!)
                
                
                guard let email = user?.email else { return }
                self.redirectToHomescreen(email: email)
            } else {
                print("\nUser is not logged in!\n")
            }
        }
    }
    
    // Checks if the user is already registered and if so
    // redirects him towards the homescreen
    func redirectToHomescreen(email: String) {
        print("\nInside of the redirectHomeScreen function\n") // TESTING
        FirebaseManage.shared.isUserRegistered(email, completion: { (bool) in
            if bool == true {
                print("\nInside of getFBUserData\n") // TESTING
                self.switchToHomeScreen()
                
            } else {
                print("\n\nIn verifyUserAuthState user is not registered\n") // TESTING
            }
        })
    }
    
    func switchToHomeScreen() {
        print("\nInside of switchStoryboard\n") // TESTING
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeScreen") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
}
