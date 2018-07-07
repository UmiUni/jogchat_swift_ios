//
//  LoginViewController.swift
//  ReferHelper
//
//  Created by XMZ on 07/07/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = UserDefaults.standard
        
        if (preferences.object(forKey: "session") != nil) {
            LoginDone()
        }
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        let username = _username.text
        let password = _password.text
        
        if (username == "" || password == "") {
            return
        }
        
        DoLogin(username!, password!)
    }
    
    func DoLogin(_ username: String, _ password: String) {
        if (username.contains("admin") && password.contains("admin")) {
            let preferences = UserDefaults.standard
            preferences.set("admin", forKey: "session")
            
            DispatchQueue.main.async {
                self.LoginDone()
            }
        } else {
            let alert = UIAlertController(title: "Ooops", message: "Wrong username or password", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func LoginDone() {
        performSegue(withIdentifier: "LoginDone", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
