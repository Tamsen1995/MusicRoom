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
    
    
    
    @IBAction func followButton(_ sender: UIButton) {
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
            
            ///////////////////////////////////////////////////// TODO : implement this
            
            
            // figure out if user is already following the clicked on user
            // if so then do an unfollow action instead of a follow action
            
            self.checkIfFollowing(followerUID: followerUID, followingUID: followingUID, completion:
                { (dictionnary) in
                    if dictionnary[followingUID] != nil {
                        self.unfollow(followerUID: followerUID, followingUID: followingUID)
                    } else {
                        self.follow(followerUID: followerUID, followingUID: followingUID)
                    }
            })
            //////////////////////////////////////////////////////////
        }
    }
    
    
    func unfollow(followerUID: String, followingUID: String) {
        print("Remove -> ", followerUID, " from the following node in" , followingUID)
        print("Remove -> ", followingUID, " from the follower node in" , followerUID)

        
    }
    
    // adds follower user id to the following list
    // and the following uid to the follower following list
    func follow(followerUID: String, followingUID: String) {
        FirebaseManage.shared.createUserNodeInDb(UserNode(followerUID, "following/\(followingUID)", true))
        FirebaseManage.shared.createUserNodeInDb(UserNode(followingUID, "followers/\(followerUID)", true))
    }
    
    
    func checkIfFollowing(followerUID: String, followingUID: String, completion: @escaping (_ followingDict:  NSDictionary) -> ()) {
        
        // sender.setTitle("Unfollow", for: .normal) // I need to use this later
        
        
        // get into the uid node's parent node just like for email
        // get the userids out of the follower node of the followinguid user
        // get the userids out of the following node of the followeruid user
        // iterate to see if the looked for id already exists.
        FirebaseManage.shared.lookForUidInDb(followerUID) { (snapshot) in
            let followingArray = snapshot.children.compactMap({ (child) -> NSDictionary? in
                guard let child = child as? DataSnapshot else { return nil }
                guard let dictionnary = child.value as? NSDictionary else { return nil }
                guard let followinUids = dictionnary["following"] as? NSDictionary else { return nil }
                return followinUids
            })
            
            
            
            if followingArray.isEmpty != true {
                let followingDict = followingArray[0]
                completion(followingDict)
            } else {
                completion([:])
            }
            
            
            
        }
        
    }

    
}
