//
//  ProfessorInfoViewController.swift
//  IOSProject
//
//  Created by Chitturi,Rakesh on 10/17/16.
//  Copyright © 2016 Chitturi,Rakesh. All rights reserved.
//

import UIKit

class ProfessorInfoViewController: UIViewController {
    var professor:Professor!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var phoneNumLBL: UILabel!
    @IBOutlet weak var officeLBL: UILabel!
    @IBOutlet weak var officeHourTV: UITextView!
    @IBOutlet weak var imageIMG: UIImageView!
    @IBAction func MakeACall(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(professor.phoneNumber)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func sendMail(sender: AnyObject) {
        let email = professor.email
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "\(professor.firstName) \(professor.middleName) \(professor.lastName)"
        imageIMG.image = UIImage(named: "\(professor.firstName) \(professor.middleName) \(professor.lastName)")
        nameLBL.text = "\(professor.firstName) \(professor.middleName) \(professor.lastName)"
        emailLBL.text = professor.email
        phoneNumLBL.text = professor.phoneNumber
        officeHourTV.text = professor.officeHours
        officeLBL.text = professor.office
    }
    
    
    

    

}
