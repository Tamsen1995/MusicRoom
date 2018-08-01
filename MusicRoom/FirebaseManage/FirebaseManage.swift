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

//protocol UserDelegate: class {
//    func userUpdate(_ places: [User])
//}

class FirebaseManage {
    static let shared = FirebaseManage()
    var database : Database
    private let rootRef: DatabaseReference
    let storageRef: StorageReference
    private var path = NSLocalizedString("Users", comment: "Path Firebase")

   
    // looks for a specific email within the database
    func lookForEmailInDb(_ email: String) {
        let userRef = rootRef.child("users")
        let query = userRef.queryOrdered(byChild: "email").queryEqual(toValue: email)
        query.observe(.value) { (snapshot) in
            print("\n\n\nsnapshot : ", snapshot) // TESTING
        }
    }

    
    func createUserInAuth (_ user: signUpInfo) {
        Auth.auth().createUser(withEmail: user.userName, password: user.password) {
            (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration successful !")
            }
        }
    }
    
    // takes in the user id and then
    // creates a node for it inside of the databe
    func createUserNodeInDb(_ userNode: UserNode) {
        let userRef = rootRef.child("users").child(userNode.userId)
        let subNode = userRef.child(userNode.subNode)
        subNode.setValue(userNode.subNodeValue)
        // set subnode
        // set subnode value
    }
    
    private init () {
        database = Database.database()
        database.isPersistenceEnabled = true
        rootRef = Database.database().reference()
        rootRef.keepSynced(true)
        storageRef =  Storage.storage().reference()
        print("\n\nInitializing Firebase\n\n") // TESTING
    }
    
}
