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
    
    func addToDict(professors:[Professor]){
        var count = 1
        print(professors)
        for i in professors {
            var count1 = 0
            if dict["\(i.firstName.characters[i.firstName.characters.startIndex])"] == nil {
                keys.append("\(i.firstName.characters[i.firstName.characters.startIndex])")
                dict["\(i.firstName.characters[i.firstName.characters.startIndex])"] = [i]
                count += 1
            } else{
                dict["\(i.firstName.characters[i.firstName.characters.startIndex])"]?.append(i)
            }
            for z in schools{
                if z == i.specalization{
                count1 += 1
                }
            }
            if count1 == 0{
                schools.append(i.specalization)
            }
            
        }
        schools.sortInPlace()
        print(schools[0])
        keys.sortInPlace()
        for key in keys{
            var a = dict[key]
            a?.sortInPlace({$0.firstName<$1.firstName})
            dict[key] = a
        }

        

    }
     func numSection()->Int{
        
        return dict.count
    }
    
     func numRows(section:Int)->Int{
        return dict[keys[section]]!.count
    }
    
    
    
    
}