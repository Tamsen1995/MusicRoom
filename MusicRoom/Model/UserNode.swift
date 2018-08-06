//
//  UserNode.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/1/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

struct UserNode {
    var userId : String
    var subNode : String
    var subNodeValue : Any
    
    init (_ userId: String, _ subNode: String, _ subNodeValue: Any) {
        self.userId = userId
        self.subNode = subNode
        self.subNodeValue = subNodeValue
    }
}
