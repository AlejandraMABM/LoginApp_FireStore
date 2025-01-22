//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by Tardes on 14/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func genderSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            genderImageView.image = UIImage(named: "genderIcon-male")
        case 1:
            genderImageView.image = UIImage(named: "genderIcon-female")
        default:
            genderImageView.image = UIImage(named: "genderIcon-other")
        }
    }
    
    @IBAction func createUser(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if (validateData()) {
            Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                if let error = error {
                    // Hubo un error
                    print(error)
                    
                    let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Todo correcto
                    print("User signs up successfully")
                   
                }
            }
        }
    }
    
   
    
    func validateData() -> Bool {
        if firstNameTextField.text!.isEmpty {
            return false
        }
        if lastNameTextField.text!.isEmpty {
            return false
        }
        if usernameTextField.text!.isEmpty {
            return false
        }
        if passwordTextField.text!.isEmpty {
            return false
        }
        if repeatPasswordTextField.text!.isEmpty {
            return false
        }
        if passwordTextField.text != repeatPasswordTextField.text {
            return false
        }
        
        return true
    }
}
