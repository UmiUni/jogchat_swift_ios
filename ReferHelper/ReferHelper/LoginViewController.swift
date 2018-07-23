//
//  LoginViewController.swift
//  ReferHelper
//
//  Created by XMZ on 07/07/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let preferences = UserDefaults.standard
//
//        if (preferences.object(forKey: "session") != nil) {
//            LoginDone()
//        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let emailText = email.text
        let passwordText = password.text
        
        if (emailText == "" || passwordText == "") {
            return
        }
        
        performLogin(emailText!, passwordText!)
    }
    
    func performLogin(_ email: String, _ password: String) {
        // prepare json data
        let json: [String: String] = [
            "Email": email,
            "Password": password,
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: API.Signin)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for any errors
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: String] {
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    // error res
                    DispatchQueue.main.async {
                        self.popupAlert(title: "Error", message: responseJSON[ResponseKey.Error]!)
                    }
                    return
                }
                // good res
                let preferences = UserDefaults.standard
                preferences.set(responseJSON[ResponseKey.Token], forKey: "token")
                
                DispatchQueue.main.async {
                    self.goToMainTabView()
                }
            }
        }
        
        task.resume()
    }
    
    func popupAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func goToMainTabView() {
        let mainTabViewController = storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
        mainTabViewController.selectedViewController = mainTabViewController.viewControllers?[0]
        present(mainTabViewController, animated: true, completion: nil)
    }
}
