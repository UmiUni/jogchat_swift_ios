//
//  CreateAccount.swift
//  ReferHelper
//
//  Created by XMZ on 07/15/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit

class SignupEmailViewController: UIViewController {
    var email = ""
    
    @IBOutlet weak var Message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSignup(email)
    }
    
    func performSignup(_ emailText:String) {
        // prepare json data
        let json: [String: String] = ["Email": emailText]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: API.ReferrerCheckSignupEmail)!
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
                    DispatchQueue.main.async {
                        self.updateMessage(responseJSON[ResponseKey.Error]!)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.updateMessage(responseJSON[ResponseKey.Message]!)
                }
            }
        }
        
        task.resume()
    }
    
    func updateMessage(_ message:String) {
        self.Message.text = message
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
