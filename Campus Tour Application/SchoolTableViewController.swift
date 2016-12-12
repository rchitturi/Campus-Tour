//
//  SchoolTableViewController.swift
//  Campus Tour Application
//
//  Created by Chitturi,Rakesh on 11/13/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import UIKit

class SchoolTableViewController: UITableViewController {
    var secRows = SecRows()
    //Loads first time when page loads
    override func viewDidLoad() {
        super.viewDidLoad()
        //Populating professors from back4app
        ProfessorsInbuilding.populateProfessors()
        //Adding them to dic to provide sections and rows
        secRows.addToDict(ProfessorsInbuilding.professors)
        //to refresh data
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(SchoolTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        // Do any additional setup after loading the view.
    }
    //To refresh data it calls this function
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        ProfessorsInbuilding.professors = []
        ProfessorsInbuilding.populateProfessors()
        secRows.addToDict(ProfessorsInbuilding.professors)
        
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    //number of schools in table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return secRows.schools.count
    }
    
    //Data for each cell is assigned here
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("schools", forIndexPath: indexPath)
        cell.textLabel?.text = secRows.schools[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    //Transfers professors data to next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let proDep = segue.destinationViewController as! ProfeesorByDepartmetTableViewController
        for professor in ProfessorsInbuilding.professors {            if professor.specalization == secRows.schools[(tableView.indexPathForSelectedRow?.row)!]{
            proDep.professors.append(professor)
            }
        }
    }
    
}
