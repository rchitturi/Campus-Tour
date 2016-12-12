//
//  BuildingsViewController.swift
//  Campus Tour Application
//
//  Created by Chitturi,Rakesh on 11/8/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import UIKit

class BuildingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //Tableview for showing buildings
    @IBOutlet weak var buildingTV: UITableView!
    //Pull to refresh option
    var refreshControl = UIRefreshControl()
    //Loads first time page loads
    override func viewDidLoad() {
        super.viewDidLoad()
        //making table view delegate and data source
        buildingTV.delegate = self
        buildingTV.dataSource = self
        //Giving title to professors
        self.title = "Buildings"
        //To populate building from SecRows
        ProfessorsInbuilding.populateBuildings()
        //To load data after fetching information
        self.buildingTV.reloadData()
        //To refresh data
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(BuildingsViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        buildingTV.addSubview(refreshControl)
        
    }
    //Method called after pulling
    func refresh(sender:AnyObject)
    {
        
        self.buildingTV.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    //Number of buildings
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfessorsInbuilding.buildings.count
    }
    //Data for each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("buildings")
        cell?.textLabel?.text = ProfessorsInbuilding.buildings[indexPath.row]
        cell?.imageView?.image = UIImage(named: ProfessorsInbuilding.buildings[indexPath.row])
        return cell!
    }
    //professors data transfer to next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let professorsInBuilding = segue.destinationViewController as! ListFacultyWithBuildingsTableViewController
        for professor in ProfessorsInbuilding.professors {
            
            if professor.building == ProfessorsInbuilding.buildings[(buildingTV.indexPathForSelectedRow?.row)!]{
                professorsInBuilding.professor.append(professor)
            }
        }
    }
    

    

}
