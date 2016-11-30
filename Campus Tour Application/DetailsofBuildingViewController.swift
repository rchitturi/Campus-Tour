//
//  DetailsofBuildingViewController.swift
//  Campus Tour Application
//
//  Created by Parimi,Teja on 11/14/16.
//  Copyright © 2016 Parimi,Teja. All rights reserved.
//

import UIKit

class DetailsofBuildingViewController: UIViewController {

    @IBOutlet weak var descriptionArea: UITextView!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var buildingImage: UIImageView!
    
    var input: String = ""
    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    var buildings:[Building] = []
    
    func populate(){
        
        
        
        
        let ColdenHall = Building(name: "Colden Hall", image: "coldenHall.png", description: "Purpose: OfficeClassroom \nTotal S Ft 78,145 \nYear Built: 1957")
        buildings.append(ColdenHall)
        
        let Library = Building(name: "Owens Library", image: "library.png", description: "Purpose: Office/Study Facility\nTotal Sq. Ft.: 116,000\n Year Built: 1981")
        buildings.append(Library)
        let AdministrationBlock = Building(name: "Administration Building", image: "adminBuilding.png", description: "Purpose: Office/Study Facility\nTotal Sq. Ft.: 116,000\nYear Built: 1981")
        buildings.append(AdministrationBlock)
        let StudentUnion = Building(name: "Student Union", image: "studentUnion.png", description: "Purpose: Office/General Use\nTotal Sq. Ft.: 113,653\nYear Built: 1950")
        buildings.append(StudentUnion)
        
        let Wellshall = Building(name: "Wells Hall", image: "wellsHall.png", description: "Purpose: Office/Classroom\nTotal Sq. Ft.: 60,816\nYear Built: 1938")
        buildings.append(Wellshall)
        
        let ValkCenter = Building(name: "Valk Center", image: "valkCenter.png", description: "Purpose: Office/Classroom\nTotal Sq. Ft.: 47,362\nYear Built: 1968")
        buildings.append(ValkCenter)
        let RonHouston = Building(name: "Ron Houston Center", image: "ronHouston.png", description: "Purpose: Office/Classroom/General Use\nTotal Sq. Ft.: 45,394\nYear Built: 1981")
        buildings.append(RonHouston)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populate()
        
        for building in buildings{
            if "\(building.name)" == input{
                nameTF.text = building.name
                descriptionArea.text = building.description
                buildingImage.image = UIImage(named: "\(building.image)")
            }
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
