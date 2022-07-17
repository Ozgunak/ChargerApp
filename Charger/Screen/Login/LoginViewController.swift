//
//  ViewController.swift
//  Charger
//
//  Created by ozgun on 25.06.2022.
//

import UIKit

class LoginViewController: UIViewController  {

    var interactor: LoginLogic?
    var router: Routable?

    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let router = Router()
        viewController.interactor = interactor
        viewController.router = router
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .clear
        let backgroundLayer = Colors().gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)

    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
        emailTextField.borderStyle = .none
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        self.title = "Giriş Yapın"
        
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, !email.isEmpty {
            if checkEmailVerification(email) {
                interactor?.loginWith(email: email, completion: { accessGranted in
                    switch accessGranted {
                    case true:
                            DispatchQueue.main.async {
                                self.router?.routeToMain(from: self.navigationController!)
                            }
                    case false:
                        print("Error")
                    }
                })
            }
        }
        
    }
    
    func checkEmailVerification(_ emailText: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailText)
    }
    
}



