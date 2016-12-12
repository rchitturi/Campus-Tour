//
//  Museums.swift
//  A Work of Art
//
//  Created by Michael Rogers on 10/12/16.
//  Copyright © 2016 Michael Rogers. All rights reserved.
//

import Foundation
import Parse

class ProfessorsInbuilding {
    static var buildings:[String]! = []
    static var professors:[Professor]! = []
    static var schools:[String]! = []
    static var professorsInBuilding:[Professor]! = []
    
    init(){
    }
    //To populate professors from back4app
    class func populateProfessors(){
        let query = PFQuery(className: "Professor")
        query.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.professors = objects as! [Professor]
            }
        })
        
    }
    //To populate buildings from back4app
    class func populateBuildings(){
        let query = PFQuery(className: "Professor")
        query.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.professors = objects as! [Professor]
            }
        })
        for professor in professors{
            if !buildings .contains(professor.building){
                buildings.append(professor.building)
            }
        }
    }
    
    
    
}