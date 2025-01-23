//
//  ViewController.swift
//  LoginApp
//
//  Created by Tardes on 14/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SignInViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let username = usernameTextField.text!
        Auth.auth().sendPasswordReset(withEmail: username) { error in
            if (error != nil) {
                print(error!.localizedDescription)
            }
        }
        let alert = UIAlertController(title: "Recuperar contraseña", message: "Te hemos enviado un correo a \(username) para recuperar tu contraseña.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
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
    
   
   
        @IBAction func googleSignIn(_ sender: Any) {
            // Configure Google SignIn with Firebase
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                    print("no token found in googlesigin")
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { result, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    // at this point , our user is signed in
                    self.performSegue(withIdentifier: "goToHome", sender: nil)
                }
            }
        
    }
}

