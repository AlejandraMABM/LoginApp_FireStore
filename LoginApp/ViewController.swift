//
//  ViewController.swift
//  LoginApp
//
//  Created by Tardes on 14/1/25.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: usernameTextField.text!,  password:passwordTextField.text!) { authResult, error in
            if let error = error {
                // hubi un error
                print(error)
                
                let alertController = UIAlertController(title: "Create User", message: error.localizedDescription, preferredStyle: .alert)

        

                alertController.addAction(UIAlertAction(title: "OK", style: .default) )

                self.present(alertController, animated: true, completion: nil)
                
            } else {
                // todo correcto
                print("User signs up successfully")
                let alertController = UIAlertController(title: "Create User", message: "User created successfully", preferredStyle: .alert)

        

                alertController.addAction(UIAlertAction(title: "OK", style: .default) )

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameTextField.text!,  password:passwordTextField.text!) { [unowned self] authResult, error in
            // guard let strongSelf = self else { return }
            if let error = error {
                let alertController = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)
                
                
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default) )
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                print("User signs up successfully")
                self.performSegue(withIdentifier: "goToHome", sender:nil)
                
                
            }
        }
    }
}

