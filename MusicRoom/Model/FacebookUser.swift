//
//  User.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/1/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

struct FacebookUser: Decodable {
    let email: String
    let id: String
    let name: String
    let picture
}

/*
 BUDERDATA  :  Optional({
 email = "tamsen95@hotmail.de";
 id = 10217285237508914;
 name = "Tam Anh Bui";
 picture =     {
 data =         {
     height = 200;
     "is_silhouette" = 0;
     url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10217285237508914&height=200&width=200&ext=1536327614&hash=AeSlGaZTyquMiHSO";
     width = 200;
     };
     };
 })
 
 */
