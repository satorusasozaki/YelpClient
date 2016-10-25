//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 115
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        
//        //Example of Yelp search with more search options specified
//         Business.searchWithTerm(term: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
//         self.businesses = businesses
//         
//         for business in businesses {
//         print(business.name!)
//         print(business.address!)
//         }
//         }
 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businesses {
            return businesses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
        print("Segue called")
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil) {(businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }
    }
}

// SearchBar methods
extension BusinessesViewController : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.searchWithTerm(term: searchBar.text!, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            }
        )
        searchBar.resignFirstResponder()
    }
}
