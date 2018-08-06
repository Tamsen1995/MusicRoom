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
    
    //    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleUsers()
        // Setup the Search Controller
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
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
    

    // TESTING
    private func loadSampleUsers() {
        let user1 = "test@test.com"
        let user2 = "Brian.corrieri@fairtrip.test"
        let user3 = "Corentin@fairtrip.org"
        let user4 = "yesitstam@gmail.com"
        let user5 = "tamsen95@hotmail.de"        
        filteredSearch += [user1, user2, user3, user4, user5] // TESTING
    }
    
}

// Responsible for all searchbar actions
extension FindUsersViewController {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("\nBeginning to edit\n") // TESTING
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("\nEnding to edit\n") // TESTING
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("\nCancelling edit\n") // TESTING
        searchActive = false
        // Hide the cancel button
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    // The search is supposed to happen by email, so when searching it will query the db for emails
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            self.filteredSearch.removeAll()
            tableView.reloadData()
        }
        
        
        // getting an array of the searched for addresses out of the firebase
        FirebaseManage.shared.lookForEmailInDb(searchText.lowercased()) { (snapshot) in
            let emailsArray = snapshot.children.compactMap({ (child) -> String? in
                guard let child = child as? DataSnapshot else { return nil }
                guard let dictionnary = child.value as? NSDictionary else { return nil }
                guard let emails = dictionnary["email"] as? String else { return nil }
                return emails
            })
            
            // checking if the userAddresses already exist
            // in the filtered search array
            for userAddress in emailsArray {
                if self.filteredSearch.contains(userAddress) == false {
                    self.filteredSearch.append(userAddress)
                }
            }
            print("\nthe search is\n", self.filteredSearch) // TESTING
            self.tableView.reloadData()
        }
    }
    
}
