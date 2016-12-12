//
//  ListFacultyWithBuildingsTableViewController.swift
//  IOSProject
//
//  Created by Chitturi,Rakesh on 10/17/16.
//  Copyright © 2016 Chitturi,Rakesh. All rights reserved.
//

import UIKit

class ListFacultyWithBuildingsTableViewController: UITableViewController {
    //Array to populate data
    var professor:[Professor] = []
    //Data type for secRows is SecRows
    var secRows:SecRows!
    
    //Loads once page loads
    override func viewDidLoad() {
        super.viewDidLoad()
        //Object for SecRows Class
        secRows = SecRows()
        //Loads table view everytime
        self.tableView.reloadData()
        //Adding professors to dictionary
        secRows.addToDict(professor)
        //Refreshes when pulled down
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(ListFacultyWithBuildingsTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        //Adding to view
        tableView.addSubview(refreshControl!)
    }
    //pull to refresh
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        professor = []
        //Adding Professors to dictionary
        secRows.addToDict(professor)
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    //Loads everytime vew loads
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Professors"
        self.tableView.reloadData()
        
    }

   

    //Number of sections 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //Professor with same first character
        return secRows.numSection()
    }
    //Number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows are professors with same name characters
        return secRows.numRows(section)
    }

    //Data for each cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("faculty_cell", forIndexPath: indexPath)
        let profsor = secRows.dict[secRows.keys[indexPath.section]]![indexPath.row]
        cell.textLabel!.text = "\(profsor.firstName) \(profsor.middleName) \(profsor.lastName)"
        let imageFromServer = profsor.image
        imageFromServer.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)-> Void in
            if (error == nil){
                cell.imageView?.image = UIImage(data: imageData!)
            }
        })
        return cell
    }
    //Title for header
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(secRows.keys)[section]
    }
    //ProfessorData transfer to next view cotroller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let professorInfoVC = segue.destinationViewController as! ProfessorInfoViewController
        let professorForSelectedRow = secRows.dict[secRows.keys[tableView.indexPathForSelectedRow!.section]]![tableView.indexPathForSelectedRow!.row]
        professorInfoVC.professor = professorForSelectedRow
    }
    //Array of characters for title
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return secRows.keys
    }
    //This methos is to return section when selected character is tapped
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let temp = secRows.keys as NSArray
        
        return temp.indexOfObject(title)
    }

    

}
