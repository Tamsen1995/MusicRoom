//
//  User.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/1/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

class User {
    var userId : String
    var userName : String
    var email : String
    var name : String
    
    enum Keys: String {
        case userId, userName, email, name
    }
    
    convenience init?(_ dictionnary: NSDictionary) {
        guard let userId = dictionnary[Keys.userId.rawValue] as? String else { return nil }
        guard let userName = dictionnary[Keys.userName.rawValue] as? String else { return nil }
        guard let email = dictionnary[Keys.userName.rawValue] as? String else { return nil }
        guard let name = dictionnary[Keys.name.rawValue] as? String else { return nil }
        
//        print("\nTesting: ", email) // TESTING
        
        
        self.init(userId, userName, email, name)
    }
    
    
    init (_ userId: String, _ userName: String, _ email: String, _ name : String) {
        self.userId = userId
        self.userName = userName
        self.email = email
        self.name = name
    }
}
