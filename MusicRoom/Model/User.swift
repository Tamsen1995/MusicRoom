//
//  User.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/1/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

struct User {
    var userId : String
    var userName : String
    var email : String
    var name : String
    
    enum Keys: String {
        case userId, userName, email, name
    }
    
    
    init (_ userId: String, _ userName: String, _ email: String, _ name : String) {
        self.userId = userId
        self.userName = userName
        self.email = email
        self.name = name
    }
}
