//
//  File.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/26/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

struct signUpInfo {
    var userName : String
    var password : String
    init (_ name: String, _ pass: String) {
        self.userName = name
        self.password = pass
    }
}
