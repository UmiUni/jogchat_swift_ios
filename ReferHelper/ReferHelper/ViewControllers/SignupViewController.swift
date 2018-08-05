//
//  SignupViewController.swift
//  ReferHelper
//
//  Created by XMZ on 07/15/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    var resettingPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (resettingPassword) {
            messageLabel.text = "Send Reset\nPassword Email"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateEmail(_ email:String) -> Bool {
        return email != ""
    }
    
    @IBAction func NextButton(_ sender: UIButton) {
        if (!validateEmail(email.text!)) {
            return
        }
        
        self.performSegue(withIdentifier: "signupNext", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signupNext") {
            let createAccountVC = segue.destination as! SignupEmailViewController
            createAccountVC.email = self.email.text!
            createAccountVC.resettingPassword = self.resettingPassword
        }
    }

}
