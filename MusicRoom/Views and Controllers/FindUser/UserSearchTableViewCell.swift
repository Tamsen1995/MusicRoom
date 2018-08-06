//
//  UserSearchTableViewCell.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/3/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

class UserSearchTableViewCell: UITableViewCell {
    
    // MARK : Properties
    @IBOutlet weak var emailAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func followButton(_ sender: Any) {
        print("\nInside of follow Button\n")  // TESTING
        guard let email = emailAddress?.text else { fatalError("\nCould not get email address\n") }
        FirebaseManage.shared.lookForEmailInDb(email.lowercased()) { (snapshot) in
            let uidArray = snapshot.children.compactMap({ (child) -> String? in
                guard let child = child as? DataSnapshot else { return nil }
                guard let dictionnary = child.value as? NSDictionary else { return nil }
                guard let uids = dictionnary["uid"] as? String else { return nil }
                return uids
            })
            guard let user = Auth.auth().currentUser else { fatalError("\nCould not get current user\n") }
            let followerUID = user.uid
            let followingUID = uidArray[0]
            self.follow(followerUID: followerUID, followingUID: followingUID)
        }
    }
    
    // adds follower user id to the following list
    // and the following uid to the follower following list
    func follow(followerUID: String, followingUID: String) {
        FirebaseManage.shared.createUserNodeInDb(UserNode(followerUID, "following", followingUID))
        FirebaseManage.shared.createUserNodeInDb(UserNode(followingUID, "followers", followerUID))
    }
    
    
}
