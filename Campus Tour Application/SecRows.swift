//
//  sec&rows.swift
//  Campus Tour Application
//
//  Created by Prem sagar Kondaparthy on 10/25/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import Foundation
class SecRows {
    var dict = [String:[Professor]]()
    var keys:[String] = []
    var schools:[String] = []
    //To add professors to dictionary for having sections and rows
    func addToDict(professors:[Professor]){
        var count = 1
        for professor in professors {
            var count1 = 0
            
            if dict["\(professor.firstName.characters[professor.firstName.characters.startIndex])"] == nil {
                keys.append("\(professor.firstName.characters[professor.firstName.characters.startIndex])")
                dict["\(professor.firstName.characters[professor.firstName.characters.startIndex])"] = [professor]
                count += 1
            } else{
                dict["\(professor.firstName.characters[professor.firstName.characters.startIndex])"]?.append(professor)
            }
            for z in schools{
                if z == professor.specalization{
                count1 += 1
                }
            }
            if count1 == 0{
                schools.append(professor.specalization)
            }
            
        }
        //Sorting schools/depts after adding them to dictionaries
        schools.sortInPlace()
        //Sorting keys in dictionary
        keys.sortInPlace()
        //Sorting values in dictionary
        for key in keys{
            var a = dict[key]
            a?.sortInPlace({$0.firstName<$1.firstName})
            dict[key] = a
        }
    }
    //For Number of sections
    func numSection()->Int{
        
        return dict.count
    }
    //For number of rows
    func numRows(section:Int)->Int{
        return dict[keys[section]]!.count
    }
    
    
    
    
}