//
//  LoginVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 7/2/22.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    var response: Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn?.layer.cornerRadius = 6
        
    }
    
    
    
    @IBAction func buttonLoginTapped(_ sender: Any){
        
        let params : [String: Any] = [
            "email": emailTF.text ?? "",
            "password": passwordTF.text ?? ""
        ]
        
        DataMapper.shared.login(params: params) {
            response in
            
            if response == nil {
                // Error de conexión
            }
            else {
                DispatchQueue.main.async {
                    
                    self.response = response
                    //                    self.tableView.isHidden = false
                    //                    self.tableView.reloadData()
                    
                    if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeId"){
                        homeuser.modalPresentationStyle = .fullScreen
                        self.present(homeuser, animated: true, completion: nil)
                    }
                    
                }
                
            }
        }
    }
}

