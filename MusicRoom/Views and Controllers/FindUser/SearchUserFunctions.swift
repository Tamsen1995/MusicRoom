//
//  SearchUserFunctions.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 8/7/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit
import Firebase

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
