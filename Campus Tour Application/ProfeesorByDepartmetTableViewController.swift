//
//  ProfeesorByDepartmetTableViewController.swift
//  Campus Tour Application
//
//  Created by Chitturi,Rakesh on 11/13/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import UIKit

class ProfeesorByDepartmetTableViewController: UITableViewController {
    var professors:[Professor]! = []
    var keys:[String]! = []
    var count = 0
    var secRows = SecRows()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Professors"
        professors.sortInPlace({$0.firstName<$1.firstName})
        for professor in professors{
        for key in keys {
            if key == "\(professor.firstName.characters[professor.firstName.characters.startIndex])"{
                count += 1
            }
        }
            if count == 0{
                keys.append("\(professor.firstName.characters[professor.firstName.characters.startIndex])")
            }
        }
        secRows.addToDict(professors)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return secRows.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return secRows.numRows(section)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("professors", forIndexPath: indexPath)
        let a = secRows.dict[secRows.keys[indexPath.section]]![indexPath.row]
        cell.textLabel?.text = "\(a.firstName) \(a.middleName) \(a.lastName)"
        // Configure the cell...
        cell.imageView?.image = UIImage(named: "\(a.firstName) \(a.middleName) \(a.lastName)")
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let proiVC = segue.destinationViewController as! ProfessorInfoViewController
        proiVC.professor = secRows.dict[secRows.keys[tableView.indexPathForSelectedRow!.section]]![tableView.indexPathForSelectedRow!.row]
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(secRows.keys)[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return secRows.keys
    }
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let temp = secRows.keys as NSArray
        
        return temp.indexOfObject(title)
    }


}
