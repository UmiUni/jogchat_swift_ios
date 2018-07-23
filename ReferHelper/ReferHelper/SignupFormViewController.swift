//
//  SignupFormViewController.swift
//  ReferHelper
//
//  Created by XMZ on 07/22/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class SignupFormViewController: UIViewController {
    var email = ""
    var token = ""
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStartedButton.isEnabled = false
        
        password.addTarget(self, action: #selector(SignupFormViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        passwordConfirm.addTarget(self, action: #selector(SignupFormViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        username.addTarget(self, action: #selector(SignupFormViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    func isValid() -> Bool {
        return password.text != "" && password.text == passwordConfirm.text && username.text != ""
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if ( self.isValid() ) {
            getStartedButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            getStartedButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            getStartedButton.isEnabled = true
        } else {
            getStartedButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            getStartedButton.setTitleColor(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1), for: .normal)
            getStartedButton.isEnabled = false
        }
    }
    
    @IBAction func getStartedPressed(_ sender: UIButton) {
        // prepare json data
        let json: [String: String] = [
            "Email": email,
            "Password": password.text!,
            "Token": token,
            "Username": username.text!
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: API.ActivateAndSignup)!
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
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func goToMainTabView() {
        self.performSegue(withIdentifier: "signupFormNext", sender: self)
    }

}
