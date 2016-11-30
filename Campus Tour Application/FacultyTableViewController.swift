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
    override func viewDidLoad() {
        super.viewDidLoad()
        secRows = SecRows()
        ProfessorsInbuilding.populateProfessors()
        secRows.addToDict(ProfessorsInbuilding.professors)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Professors"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return secRows.numSection()
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secRows.numRows(section)
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("faculty", forIndexPath: indexPath)
        let profsor = secRows.dict[secRows.keys[indexPath.section]]![indexPath.row]
        cell.textLabel!.text = "\(profsor.firstName) \(profsor.middleName) \(profsor.lastName)"
        cell.imageView?.image = UIImage(named: "\(profsor.firstName) \(profsor.middleName) \(profsor.lastName)")
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(secRows.keys)[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return secRows.keys
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let professorInfoVC = segue.destinationViewController as! ProfessorInfoViewController
        let a = secRows.dict[secRows.keys[tableView.indexPathForSelectedRow!.section]]![tableView.indexPathForSelectedRow!.row]
        professorInfoVC.professor = a
    }
    
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let temp = secRows.keys as NSArray
        
        return temp.indexOfObject(title)
    }
    
    

    

}
