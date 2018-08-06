//
//  UserSearchTableViewCell.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/3/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

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
        print("\nInside of follow Button\n") // TESTING
        
        // get own user id
        
        // get the user id of the email of the current cell
        
        // add own user id to the clicked on user's followers list
        
        // add the clicked on user's uid to own following list
        
    }
    

}
