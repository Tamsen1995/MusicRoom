//
//  HomeScreenViewController.swift
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

class ProfileUserScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            let manager = FBSDKLoginManager()
            manager.logOut()
            try firebaseAuth.signOut()
            // Go back to the starting screen
            self.present(HandleViews().switchScreen("StartScreen"), animated: true, completion: nil)
            print("User signed out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    

}
