//
//  UsernamePriomptViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/2/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class UsernamePromptViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    var uid: String = ""
    var email: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseName(_ sender: Any) {
        guard let userName = username.text else { return }
        var userNode = UserNode(self.uid, "username", userName)
        
        FirebaseManage.shared.createUserNodeInDb(userNode)
        userNode = UserNode(self.uid, "email", self.email)
        FirebaseManage.shared.createUserNodeInDb(userNode)
        print("\nUsername chosen\n") // TESTING
        self.dismiss(animated: false, completion: nil)

    }

}
