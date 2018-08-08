//
//  FindUsersViewController.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/1/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

class FindUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    var searchActive : Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredSearch: [String] = []
    
    
    /////////////////// TESTING
    func loadSampleUsers() {
        let user1 = "yesitstam@gmail.com"
        let user2 = "tamsen95@hotmail.de"
        
        filteredSearch += [user1, user2]
        
    }
    
    /////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loadSampleUsers()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserSearchCellIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath ) as? UserSearchTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let user = filteredSearch[indexPath.row]
        cell.emailAddress.text = user
        return cell
    }
    
}
