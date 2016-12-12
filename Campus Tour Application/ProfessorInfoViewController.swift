//
//  ProfessorInfoViewController.swift
//  IOSProject
//
//  Created by Chitturi,Rakesh on 10/17/16.
//  Copyright © 2016 Chitturi,Rakesh. All rights reserved.
//

import UIKit
import Parse

class ProfessorInfoViewController: UIViewController {
    var professor:Professor!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //name of professor
    @IBOutlet weak var nameLBL: UILabel!
    //Email of professor
    @IBOutlet weak var emailLBL: UILabel!
    //Phone Number of professor
    @IBOutlet weak var phoneNumLBL: UILabel!
    //Office of professor
    @IBOutlet weak var officeLBL: UILabel!
    //Office Hours of professor
    @IBOutlet weak var officeHourTV: UITextView!
    //Professor image
    @IBOutlet weak var imageIMG: UIImageView!
    //Building in which professor stays
    @IBOutlet weak var buildingLBL: UILabel!
    //To call professor when call image is tapped
    @IBAction func MakeACall(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(professor.phoneNumber)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    //To mail professor whem mail button is tapped
    @IBAction func sendMail(sender: AnyObject) {
        let email = professor.email
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    //Calls everytime view appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //sets title of view controller to professor name
        self.navigationItem.title = "\(professor.firstName) \(professor.middleName) \(professor.lastName)"
        //Image of professor to stored image in server
        let imageFromServer = professor.image
        imageFromServer.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)-> Void in
            if (error == nil){
                self.imageIMG.image = UIImage(data: imageData!)
            }
        })
        //Assigning details to professor concerned labels from server
        nameLBL.text = "\(professor.firstName) \(professor.middleName) \(professor.lastName)"
        emailLBL.text = professor.email
        phoneNumLBL.text = professor.phoneNumber
        officeHourTV.text = professor.officeHours
        officeLBL.text = professor.office
        buildingLBL.text = professor.building
    }
    
    
    

    

}
