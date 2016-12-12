//
//  FacultyTableViewController.swift
//  IOSProject
//
//  Created by Chitturi,Rakesh on 10/17/16.
//  Copyright © 2016 Chitturi,Rakesh. All rights reserved.
//

import UIKit

class FacultyTableViewController: UITableViewController {
    var professors:[Professor] = []
    var secRows:SecRows!
    //Loads when view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secRows = SecRows()
        ProfessorsInbuilding.populateProfessors()
        secRows.addToDict(ProfessorsInbuilding.professors)
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(FacultyTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
        
    }
    //Pull to refresh
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        ProfessorsInbuilding.professors = []
        ProfessorsInbuilding.populateProfessors()
        
        secRows.addToDict(ProfessorsInbuilding.professors)
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    //This calls every time page loads
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Professors"
        self.tableView.reloadData()
    }
    
    //Number of sections in table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //Professors with different first name alphabets
        return secRows.numSection()
        
    }
    //number of rows in section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //No of professors with same first name character
        return secRows.numRows(section)
        
    }
    
    //data for a particular cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("faculty", forIndexPath: indexPath)
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
    //Title for section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(secRows.keys)[section]
    }
    //For Index Bar
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return secRows.keys
    }
    //Data to transfer to next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let professorInfoVC = segue.destinationViewController as! ProfessorInfoViewController
        let a = secRows.dict[secRows.keys[tableView.indexPathForSelectedRow!.section]]![tableView.indexPathForSelectedRow!.row]
        professorInfoVC.professor = a
    }
    
    //For index bar
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let temp = secRows.keys as NSArray
        
        return temp.indexOfObject(title)
    }
    
    
    
    
    
}
