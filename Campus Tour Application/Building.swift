//
//  Building.swift
//  Campus Tour Application
//
//  Created by Parimi,Teja on 11/14/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import Foundation

class Building{
    var name:String
    var image:String
    var description:String
    
    //this is an initalizer
    init(name:String,image:String,description:String){
        self.name = name
        self.description = description
        self.image = image
    }
}
