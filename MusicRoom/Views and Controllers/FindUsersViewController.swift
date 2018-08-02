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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var filtered:[String] = []
    
    
    //    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\nSearching\n") // TESTING
        FirebaseManage.shared.lookForEmailInDb(searchText.lowercased()) { (snapshot) in
            print("\nSnapshot inside of textdidchange\n\n", snapshot)

            
            
            // snapshot is in here
        }
    }
    
    // TODO :
    // get snapshot into tableview compatible data
    // populate all the prototype cells with the results of snapshot
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
        
    }

    

    //
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        if(searchActive) {
    //            return filtered.count
    //        }
    //        return data.count;
    //    }
    //
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell;
    //        if(searchActive){
    //            cell.textLabel?.text = filtered[indexPath.row]
    //        } else {
    //            cell.textLabel?.text = data[indexPath.row];
    //        }
    //
    //        return cell;
    //    }
    //}
    
    
    
    
}

extension FindUsersViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}
