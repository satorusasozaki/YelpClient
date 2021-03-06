//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Satoru Sasozaki on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersTableViewControllerDelegate {
    @objc optional func filtersTableViewController(filtersTableViewController: FiltersTableViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersTableViewController: UITableViewController, SwitchCellDelegate {

    weak var delegate: FiltersTableViewControllerDelegate?

    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    
    @IBOutlet weak var africanCategorySwitch: UISwitch!
    @IBOutlet weak var barbequeCategorySwitch: UISwitch!
    @IBOutlet weak var cafeteriaCategorySwitch: UISwitch!
    
    @IBOutlet weak var bestMatchSortSwitch: UISwitch!
    @IBOutlet weak var distanceSortSwitch: UISwitch!
    @IBOutlet weak var highestRatedSwitch: UISwitch!
    
    @IBOutlet weak var oneMileSwitch: UISwitch!
    @IBOutlet weak var fiveMilesSwitch: UISwitch!
    @IBOutlet weak var tenMilesSwitch: UISwitch!
    
    @IBOutlet weak var dealSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = yelpCategories()
        
        africanCategorySwitch.isOn = false
        barbequeCategorySwitch.isOn = false
        cafeteriaCategorySwitch.isOn = false
        
        bestMatchSortSwitch.isOn = false
        distanceSortSwitch.isOn = false
        highestRatedSwitch.isOn = false
        
        oneMileSwitch.isOn = false
        fiveMilesSwitch.isOn = false
        tenMilesSwitch.isOn = false
        
        dealSwitch.isOn = false
        
    }

    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: {})
    }
    @IBAction func onSearch(_ sender: UIBarButtonItem) {
        var filters = [String: AnyObject]()
        
        // categories
        var selectedCategories = [String]()
        if africanCategorySwitch.isOn {
            selectedCategories.append(categories[0]["code"]!)
        }
        if barbequeCategorySwitch.isOn {
            selectedCategories.append(categories[1]["code"]!)
        }
        if cafeteriaCategorySwitch.isOn {
            selectedCategories.append(categories[2]["code"]!)
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject
        }
        
        // sort
        var selectedSort = YelpSortMode.bestMatched
        if bestMatchSortSwitch.isOn {
            selectedSort = YelpSortMode.bestMatched
        } else if distanceSortSwitch.isOn {
            selectedSort = YelpSortMode.distance
        } else if highestRatedSwitch.isOn {
            selectedSort = YelpSortMode.highestRated
        }
        filters["sort"] = selectedSort as AnyObject
        
        // distance
        var selectedDistance = 10.00
        if oneMileSwitch.isOn {
            selectedDistance = 0.1
        } else if fiveMilesSwitch.isOn {
            selectedDistance = 0.5
        } else if tenMilesSwitch.isOn {
            selectedDistance = 1
        }
        filters["distance"] = selectedDistance as AnyObject
        
        // deals
        var isDealSelected = false
        if dealSwitch.isOn {
            isDealSelected = true
        }
        filters["deal"] = isDealSelected as AnyObject
        
        // if delegate exists and it implements this method, call it
        delegate?.filtersTableViewController?(filtersTableViewController: self, didUpdateFilters: filters)
        dismiss(animated: true, completion: {})
    }
    
    
    // this is called when switch value is changed in SwitchCell object
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        switchStates[indexPath.row] = value
        print("filters view controller got the switch event")
    }
    
    func yelpCategories() -> [[String:String]] {
        return [["name" : "African", "code": "african"],
                ["name" : "Barbeque", "code": "bbq"],
                ["name" : "Cafeteria", "code": "cafeteria"]]
    }
    
        
//    func yelpCategories() -> [[String:String]] {
//        return [["name" : "Afghan", "code": "afghani"],
//                      ["name" : "African", "code": "african"],
//                      ["name" : "American, New", "code": "newamerican"],
//                      ["name" : "American, Traditional", "code": "tradamerican"],
//                      ["name" : "Arabian", "code": "arabian"],
//                      ["name" : "Argentine", "code": "argentine"],
//                      ["name" : "Armenian", "code": "armenian"],
//                      ["name" : "Asian Fusion", "code": "asianfusion"],
//                      ["name" : "Asturian", "code": "asturian"],
//                      ["name" : "Australian", "code": "australian"],
//                      ["name" : "Austrian", "code": "austrian"],
//                      ["name" : "Baguettes", "code": "baguettes"],
//                      ["name" : "Bangladeshi", "code": "bangladeshi"],
//                      ["name" : "Barbeque", "code": "bbq"],
//                      ["name" : "Basque", "code": "basque"],
//                      ["name" : "Bavarian", "code": "bavarian"],
//                      ["name" : "Beer Garden", "code": "beergarden"],
//                      ["name" : "Beer Hall", "code": "beerhall"],
//                      ["name" : "Beisl", "code": "beisl"],
//                      ["name" : "Belgian", "code": "belgian"],
//                      ["name" : "Bistros", "code": "bistros"],
//                      ["name" : "Black Sea", "code": "blacksea"],
//                      ["name" : "Brasseries", "code": "brasseries"],
//                      ["name" : "Brazilian", "code": "brazilian"],
//                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
//                      ["name" : "British", "code": "british"],
//                      ["name" : "Buffets", "code": "buffets"],
//                      ["name" : "Bulgarian", "code": "bulgarian"],
//                      ["name" : "Burgers", "code": "burgers"],
//                      ["name" : "Burmese", "code": "burmese"],
//                      ["name" : "Cafes", "code": "cafes"],
//                      ["name" : "Cafeteria", "code": "cafeteria"],
//                      ["name" : "Cajun/Creole", "code": "cajun"],
//                      ["name" : "Cambodian", "code": "cambodian"],
//                      ["name" : "Canadian", "code": "New)"],
//                      ["name" : "Canteen", "code": "canteen"],
//                      ["name" : "Caribbean", "code": "caribbean"],
//                      ["name" : "Catalan", "code": "catalan"],
//                      ["name" : "Chech", "code": "chech"],
//                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
//                      ["name" : "Chicken Shop", "code": "chickenshop"],
//                      ["name" : "Chicken Wings", "code": "chicken_wings"],
//                      ["name" : "Chilean", "code": "chilean"],
//                      ["name" : "Chinese", "code": "chinese"],
//                      ["name" : "Comfort Food", "code": "comfortfood"],
//                      ["name" : "Corsican", "code": "corsican"],
//                      ["name" : "Creperies", "code": "creperies"],
//                      ["name" : "Cuban", "code": "cuban"],
//                      ["name" : "Curry Sausage", "code": "currysausage"],
//                      ["name" : "Cypriot", "code": "cypriot"],
//                      ["name" : "Czech", "code": "czech"],
//                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
//                      ["name" : "Danish", "code": "danish"],
//                      ["name" : "Delis", "code": "delis"],
//                      ["name" : "Diners", "code": "diners"],
//                      ["name" : "Dumplings", "code": "dumplings"],
//                      ["name" : "Eastern European", "code": "eastern_european"],
//                      ["name" : "Ethiopian", "code": "ethiopian"],
//                      ["name" : "Fast Food", "code": "hotdogs"],
//                      ["name" : "Filipino", "code": "filipino"],
//                      ["name" : "Fish & Chips", "code": "fishnchips"],
//                      ["name" : "Fondue", "code": "fondue"],
//                      ["name" : "Food Court", "code": "food_court"],
//                      ["name" : "Food Stands", "code": "foodstands"],
//                      ["name" : "French", "code": "french"],
//                      ["name" : "French Southwest", "code": "sud_ouest"],
//                      ["name" : "Galician", "code": "galician"],
//                      ["name" : "Gastropubs", "code": "gastropubs"],
//                      ["name" : "Georgian", "code": "georgian"],
//                      ["name" : "German", "code": "german"],
//                      ["name" : "Giblets", "code": "giblets"],
//                      ["name" : "Gluten-Free", "code": "gluten_free"],
//                      ["name" : "Greek", "code": "greek"],
//                      ["name" : "Halal", "code": "halal"],
//                      ["name" : "Hawaiian", "code": "hawaiian"],
//                      ["name" : "Heuriger", "code": "heuriger"],
//                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
//                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
//                      ["name" : "Hot Dogs", "code": "hotdog"],
//                      ["name" : "Hot Pot", "code": "hotpot"],
//                      ["name" : "Hungarian", "code": "hungarian"],
//                      ["name" : "Iberian", "code": "iberian"],
//                      ["name" : "Indian", "code": "indpak"],
//                      ["name" : "Indonesian", "code": "indonesian"],
//                      ["name" : "International", "code": "international"],
//                      ["name" : "Irish", "code": "irish"],
//                      ["name" : "Island Pub", "code": "island_pub"],
//                      ["name" : "Israeli", "code": "israeli"],
//                      ["name" : "Italian", "code": "italian"],
//                      ["name" : "Japanese", "code": "japanese"],
//                      ["name" : "Jewish", "code": "jewish"],
//                      ["name" : "Kebab", "code": "kebab"],
//                      ["name" : "Korean", "code": "korean"],
//                      ["name" : "Kosher", "code": "kosher"],
//                      ["name" : "Kurdish", "code": "kurdish"],
//                      ["name" : "Laos", "code": "laos"],
//                      ["name" : "Laotian", "code": "laotian"],
//                      ["name" : "Latin American", "code": "latin"],
//                      ["name" : "Live/Raw Food", "code": "raw_food"],
//                      ["name" : "Lyonnais", "code": "lyonnais"],
//                      ["name" : "Malaysian", "code": "malaysian"],
//                      ["name" : "Meatballs", "code": "meatballs"],
//                      ["name" : "Mediterranean", "code": "mediterranean"],
//                      ["name" : "Mexican", "code": "mexican"],
//                      ["name" : "Middle Eastern", "code": "mideastern"],
//                      ["name" : "Milk Bars", "code": "milkbars"],
//                      ["name" : "Modern Australian", "code": "modern_australian"],
//                      ["name" : "Modern European", "code": "modern_european"],
//                      ["name" : "Mongolian", "code": "mongolian"],
//                      ["name" : "Moroccan", "code": "moroccan"],
//                      ["name" : "New Zealand", "code": "newzealand"],
//                      ["name" : "Night Food", "code": "nightfood"],
//                      ["name" : "Norcinerie", "code": "norcinerie"],
//                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
//                      ["name" : "Oriental", "code": "oriental"],
//                      ["name" : "Pakistani", "code": "pakistani"],
//                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
//                      ["name" : "Parma", "code": "parma"],
//                      ["name" : "Persian/Iranian", "code": "persian"],
//                      ["name" : "Peruvian", "code": "peruvian"],
//                      ["name" : "Pita", "code": "pita"],
//                      ["name" : "Pizza", "code": "pizza"],
//                      ["name" : "Polish", "code": "polish"],
//                      ["name" : "Portuguese", "code": "portuguese"],
//                      ["name" : "Potatoes", "code": "potatoes"],
//                      ["name" : "Poutineries", "code": "poutineries"],
//                      ["name" : "Pub Food", "code": "pubfood"],
//                      ["name" : "Rice", "code": "riceshop"],
//                      ["name" : "Romanian", "code": "romanian"],
//                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
//                      ["name" : "Rumanian", "code": "rumanian"],
//                      ["name" : "Russian", "code": "russian"],
//                      ["name" : "Salad", "code": "salad"],
//                      ["name" : "Sandwiches", "code": "sandwiches"],
//                      ["name" : "Scandinavian", "code": "scandinavian"],
//                      ["name" : "Scottish", "code": "scottish"],
//                      ["name" : "Seafood", "code": "seafood"],
//                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
//                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
//                      ["name" : "Singaporean", "code": "singaporean"],
//                      ["name" : "Slovakian", "code": "slovakian"],
//                      ["name" : "Soul Food", "code": "soulfood"],
//                      ["name" : "Soup", "code": "soup"],
//                      ["name" : "Southern", "code": "southern"],
//                      ["name" : "Spanish", "code": "spanish"],
//                      ["name" : "Steakhouses", "code": "steak"],
//                      ["name" : "Sushi Bars", "code": "sushi"],
//                      ["name" : "Swabian", "code": "swabian"],
//                      ["name" : "Swedish", "code": "swedish"],
//                      ["name" : "Swiss Food", "code": "swissfood"],
//                      ["name" : "Tabernas", "code": "tabernas"],
//                      ["name" : "Taiwanese", "code": "taiwanese"],
//                      ["name" : "Tapas Bars", "code": "tapas"],
//                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
//                      ["name" : "Tex-Mex", "code": "tex-mex"],
//                      ["name" : "Thai", "code": "thai"],
//                      ["name" : "Traditional Norwegian", "code": "norwegian"],
//                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
//                      ["name" : "Trattorie", "code": "trattorie"],
//                      ["name" : "Turkish", "code": "turkish"],
//                      ["name" : "Ukrainian", "code": "ukrainian"],
//                      ["name" : "Uzbek", "code": "uzbek"],
//                      ["name" : "Vegan", "code": "vegan"],
//                      ["name" : "Vegetarian", "code": "vegetarian"],
//                      ["name" : "Venison", "code": "venison"],
//                      ["name" : "Vietnamese", "code": "vietnamese"],
//                      ["name" : "Wok", "code": "wok"],
//                      ["name" : "Wraps", "code": "wraps"],
//                      ["name" : "Yugoslav", "code": "yugoslav"]]
//    }
}

