//
//  GoogleAuth.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/27/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseUI

extension AppDelegate {
    
    // Is called as soon as a user signs in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print("\n\nAn error in the signIn method has occurred : ", error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            print("The user : ", user, " has signed in.")
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print(signIn)
        print("\nInside of signout\n")
        // Perform any operations when the user disconnects from app here.
        // ...
    }
 
    
}
