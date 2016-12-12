//
//  ProfeesorByDepartmetTableViewController.swift
//  Campus Tour Application
//
//  Created by Chitturi,Rakesh on 11/13/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import UIKit

class ProfeesorByDepartmetTableViewController: UITableViewController {
    //Array of professors
    var professors:[Professor]! = []
    //Creating object to secRows to get the data
    var secRows = SecRows()
    
    //Loads first time
    override func viewDidLoad() {
        super.viewDidLoad()
        //Giving title to view controller
        self.title = "Professors"
        //Reloading data
        self.tableView.reloadData()
        //Sorting received professors
        professors.sortInPlace({$0.firstName<$1.firstName})
        //Adding professors to dictionary to get sections and rows
        secRows.addToDict(professors)
        //To refresh data
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(ProfeesorByDepartmetTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        // Do any additional setup after loading the view.
    }
    //Action need to be done after pulling down
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    //Number of sections in table view
    //Characters with diff name
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return secRows.keys.count
    }
    //Number of rows in each section professors with same name
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return secRows.numRows(section)
    }

    //Loads data to each cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("professors", forIndexPath: indexPath)
        let professor = secRows.dict[secRows.keys[indexPath.section]]![indexPath.row]
        cell.textLabel?.text = "\(professor.firstName) \(professor.middleName) \(professor.lastName)"
        // Configure the cell...
        let imageFromServer = professor.image
        imageFromServer.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)-> Void in
            if (error == nil){
                cell.imageView?.image = UIImage(data: imageData!)
            }
        })
        return cell
    }
    //Tranfering data to destination view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let proiVC = segue.destinationViewController as! ProfessorInfoViewController
        proiVC.professor = secRows.dict[secRows.keys[tableView.indexPathForSelectedRow!.section]]![tableView.indexPathForSelectedRow!.row]
    }
    //Title for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(secRows.keys)[section]
    }
    //For character in index bar
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return secRows.keys
    }
    //For section to show when index is pressed
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let temp = secRows.keys as NSArray
        
        return temp.indexOfObject(title)
    }
    //Loads everytime page loads
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }


}
