//
//  PostPositionViewController.swift
//  ReferHelper
//
//  Created by XMZ on 08/12/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class PostPositionViewController: UIViewController {
    @IBOutlet weak var positionName: UITextField!
    @IBOutlet weak var positonDescription: UITextView!
    @IBOutlet weak var postButton: UIButton!
    var username: String!
    var token: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postButton.isEnabled = false
        
        prepareStoredInfo()
        prepareDescriptionTextView()
        prepareTextChange()
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        performPost()
    }
}

extension PostPositionViewController {
    private func prepareStoredInfo() {
        let preferences = UserDefaults.standard
        
        if let storedUsername = preferences.object(forKey: ResponseKey.Username) as? String {
            username = storedUsername
        } else {
            self.goToLogin()
        }
        
        if let storedToken = preferences.object(forKey: ResponseKey.Token) as? String {
            token = storedToken
        } else {
            self.goToLogin()
        }
    }
    
    private func prepareDescriptionTextView() {
        positonDescription.layer.borderWidth = 0.25
        positonDescription.layer.borderColor = UIColor.lightGray.cgColor
        positonDescription.layer.cornerRadius = 5.0
        positonDescription.textContainerInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
    }
    
    private func prepareTextChange() {
        positionName.addTarget(self, action: #selector(PostPositionViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
}

extension PostPositionViewController {
    private func isValid() -> Bool {
        return positionName.text != ""
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if ( self.isValid() ) {
            postButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            postButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            postButton.isEnabled = true
        } else {
            postButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            postButton.setTitleColor(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1), for: .normal)
            postButton.isEnabled = false
        }
    }
}

extension PostPositionViewController {
    private func performPost() {
        let json: [String: String] = [
            "Position": positionName.text!,
            "Description": positonDescription.text!,
            "Company": "Jogchat.com",
            "Username": username
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: API.PostPosition)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
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
                
                DispatchQueue.main.async {
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    private func goToLogin() {
        print("login")
    }
    
    func popupAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
