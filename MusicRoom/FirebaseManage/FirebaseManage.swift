//
//  FirebaseManage.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/26/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI

class FirebaseManage {
    static let shared = FirebaseManage()

    
    func createUserInDB (_ user: userData) {
        Auth.auth().createUser(withEmail: user.userName, password: user.password) {
            (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration successful !")
            }
        }
    }
    
    private init () {
        print("\n\nInitializing Firebase\n\n") // TESTING
    }
    
}
