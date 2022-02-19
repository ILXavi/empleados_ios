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
    @IBOutlet var eyeBtn: UIButton!
    
   
    var passVisible: Bool = true;
    
    var response: Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn?.layer.cornerRadius = 6
        
    }
        
    @IBAction func buttonLoginTapped(_ sender: Any){
        
        if (emailTF.text == "" || passwordTF.text == ""){
            self.alert(message: "Complete todos los campos")
        }else{
            let params : [String: Any] = [
                "email": emailTF.text ?? "",
                "password": passwordTF.text ?? ""
            ]
            
            
            print(params)
            DataMapper.shared.login(params: params) {
                response in
                
                
                if response == nil {
                    // Error de conexión
                }
                else {
                    DispatchQueue.main.async {
                        
                        self.response = response

                        if response?.status == 0{
                            print ("ERROR")
                        }else if response!.status == 1{
                           
                            print ("Credenciales validadas")
                            AppData.shared.apiToken = response!.msg
                            print (AppData.shared.apiToken)
                            
                            if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeId"){
                                homeuser.modalPresentationStyle = .fullScreen
                                self.present(homeuser, animated: true, completion: nil)
                            }
                            
                        }else if response!.status == 20{
                            print ("Usuario no registrado")
                            self.alert(message:response!.msg)
                            
                        }else if response!.status == 21{
                            print ("Contraseña incorrecta")
                            self.alert(message:response!.msg)
                        }
                    }
                }
            }
        }
    }
    
    public func alert(message:String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Continuar", style: .default){
            action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func viewPass(_ sender: Any){
       
        eyeBtn.isSelected = !eyeBtn.isSelected
        passwordTF.isSecureTextEntry.toggle()
        
    }
    
}


