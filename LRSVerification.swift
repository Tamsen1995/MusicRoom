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
        if FBSDKAccessToken.current() != nil {
            getFBUserData()
        }
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                print("\nUser in verifyUserAuthState : ", user)
                self.switchToHomeScreen()
            } else {
                print("\nUser is not logged in!\n")
            }
        }
    }
    
    func switchToHomeScreen() {
        print("\nInside of switchStoryboard\n") // TESTING
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeScreen") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
}
