//
//  BuildingsViewController.swift
//  Campus Tour Application
//
//  Created by Chitturi,Rakesh on 11/8/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import UIKit

class BuildingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tabTV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabTV.delegate = self
        tabTV.dataSource = self
        self.title = "Buildings"
        ProfessorsInbuilding.populateBuildings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfessorsInbuilding.buildings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("buildings")
        cell?.textLabel?.text = ProfessorsInbuilding.buildings[indexPath.row]
        cell?.imageView?.image = UIImage(named: ProfessorsInbuilding.buildings[indexPath.row])
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let a = segue.destinationViewController as! ListFacultyWithBuildingsTableViewController
        for professor in ProfessorsInbuilding.professors {
            //            print(professor.specalization )
            //            print(secRows.schools[(tableView.indexPathForSelectedRow?.row)!])
            if professor.building == ProfessorsInbuilding.buildings[(tabTV.indexPathForSelectedRow?.row)!]{
                a.professor.append(professor)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
