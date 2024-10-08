//
//  SetupScreen.swift
//  Locket for Songs
//
//  Created by Kevin Yuan on 9/21/24.
//

import UIKit
import Firebase
import FirebaseFirestore

class SetupScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextbox: UITextField?
    //@IBOutlet weak var passwordTextbox: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func createButton(_ sender: Any) {
            // Get text from the username and password textboxes
            let username = getUsername()
            //let password = getPassword()
        
            UserDefaults.standard.set(username, forKey: "username")
            // CHECK IF USERNAME IS VALID
            //IF IT IS, USER IS TRYING TO LOG IN, IF NOT, USER IS TRYING TO REGISTER
        
            print("Username: \(username)")
            
            //print("Password: \(password)")
            
            saveDataToFirestore(username)
            goToHome()
            }
            // You can add additional logic here to handle the data (e.g., validation, saving, etc.)
    func saveDataToFirestore(_ inputName: String) {
        let db = Firestore.firestore()
        let dataToStore: [String: Any] = [
            "name": inputName,
            "songList": [],
            "friendList": []
        ]
        
        // Add a new document with a generated ID
        db.collection("users").addDocument(data: dataToStore) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully!")
            }
        }
    }
    func goToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController")
        self.present(detailVC, animated: true, completion: nil)
        
    }
        // Function to retrieve the username text
    func getUsername() -> String {
        return usernameTextbox!.text ?? "No name..." // Returns the entered username or an empty string if nil
    }
        
        // Function to retrieve the password text
        //func getPassword() -> String {
        //return passwordTextbox.text ?? "" // Returns the entered password or an empty string if nil
   // }
    /*
     @IBOutlet weak var UsernameLabel: UILabel!
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
