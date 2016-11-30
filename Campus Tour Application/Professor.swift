//
//  Artwork.swift
//  A Work of Art
//
//  Created by Michael Rogers on 10/12/16.
//  Copyright © 2016 Michael Rogers. All rights reserved.
//

import UIKit
import Parse
import Bolts

class Professor:PFObject,PFSubclassing {
    @NSManaged var firstName:String
    @NSManaged var middleName:String
    @NSManaged var lastName:String
    @NSManaged var email:String
    @NSManaged var phoneNumber:String
    @NSManaged var officeHours:String
    @NSManaged var specalization:String
    @NSManaged var office:String
    @NSManaged var building:String
    
    static func parseClassName() -> String {
        return "Professor"
    }
   
}