//
//  Constants.swift
//  ReferHelper
//
//  Created by XMZ on 07/21/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import Foundation

struct API {
    static let WebBase = "http://178.128.0.108:3001"
    static let ActivateAndSignup = "\(WebBase)/activate_and_signup"
    static let AddCompany = "\(WebBase)/add_company"
    static let AddSchool = "\(WebBase)/add_school"
    static let ApplicantCheckSignupEmail = "\(WebBase)/applicant_check_signup_email"
    static let ReferrerCheckSignupEmail = "\(WebBase)/referrer_check_signup_email"
    static let ResetPasswordForm = "\(WebBase)/reset_password_form"
    static let SendResetPasswordEmail = "\(WebBase)/send_reset_password_email"
    static let Signin = "\(WebBase)/signin"
}

struct ResponseKey {
    static let Message = "message"
    static let Error = "error"
    static let Token = "AuthToken"
}

struct URLType {
    static let Signup = "signup"
    static let ResetPassword = "reset"
}
