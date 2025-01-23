//
//  ProfileViewController.swift
//  LoginApp
//
//  Created by Tardes on 23/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet var genderLabel: UIView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser!.uid
        
        let docRef = db.collection("Users").document(userID)
        
        Task {
            do {
                user = try await docRef.getDocument(as: User.self)
                print("user :\(user) ")
                DispatchQueue.main.async {
                    self.loadData()
                }
            } catch {
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func loadData() {
        
        nameTextField.text = user.firstName
        
        apellidoTextField.text = user.lastName
        userNameTextField.text = user.username
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
