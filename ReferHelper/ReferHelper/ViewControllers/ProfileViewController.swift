//
//  ProfileViewController.swift
//  ReferHelper
//
//  Created by XMZ on 07/22/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "token")
        goToWelcomeView()
    }
    
    func goToWelcomeView() {
        let welcomeNavigationController = storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeNavigationController
        present(welcomeNavigationController, animated: true, completion: nil)
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
