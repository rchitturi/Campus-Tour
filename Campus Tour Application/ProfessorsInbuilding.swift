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
    
    class func populateProfessors(){
        let query = PFQuery(className: "Professor")
        query.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.professors = objects as! [Professor]
            }
        })
        
    }
    
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
    
    class func populateProfessorsByBuilding(building:String){
        let query = PFQuery(className: "Professor")
        query.whereKey("building", equalTo: building)
        query.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.professorsInBuilding = objects as! [Professor]
            }
        })
        print(professorsInBuilding)
        
    }
    
    class func populateSchools(){
        let query = PFQuery(className: "Professor")
        query.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.professors = objects as! [Professor]
            }
        })
        for professor in professors{
            if !schools .contains(professor.specalization){
                buildings.append(professor.specalization)
            }
        }
    }
    
    class func numbuildings()->Int {
        return buildings.count
    }
    
    class func buildingNum(index:Int)->String {
        return buildings[index]
    }
//    class func sortProfessors(section:Int)->[Professor]{
//        
//        var pro = buildings[section].professors
//        pro.sortInPlace({$0.firstName<$1.firstName})
//        return pro
//        
//        
//    }
//    
//    class func allProfessors()->[Professor]{
//        var professor:[Professor] = []
//        for i in buildings {
//            professor += i.professors
//        }
//        professor.sortInPlace({$0.firstName<$1.firstName})
//        return professor
//    }
}