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
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    var passVisible: Bool = true;
    
    var response: Response?
    var localprofile: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn?.layer.cornerRadius = 6
        self.spinner.isHidden = true
        self.spinner.hidesWhenStopped = true
        
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any){
        
        //        Se verifica que los campos no esten vacios para evitar revisiones mas lentas por la API
        if (emailTF.text == "" || passwordTF.text == "" || emailTF.text == nil || passwordTF.text == nil){
            self.alert(message: "Complete todos los campos", type: .actionSheet)
        }else{
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            
            let params : [String: Any] = [
                "email": emailTF.text ?? "",
                "password": passwordTF.text ?? ""
            ]
            
            //            Se envia la petición
            print(params)
            DataMapper.shared.login(params: params) {
                response in
                
                
                if response == nil {
                    self.alert(message: "Upss! ha ocurrido un error, intentalo más tarde.", type: .alert)
                }
                else {
                    DispatchQueue.main.async {
                        
                        self.response = response
                        
                        if response?.status == 0{
                            print ("ERROR")
                            self.alert(message: "Upss! ha ocurrido un error, intentalo más tarde.", type: .alert)
                            
                            //                           DATOS VALIDOS
                        }else if response!.status == 1{
                            
                            self.spinner.stopAnimating()
                            print ("Credenciales validadas")
                            AppData.shared.apiToken = response!.msg
                            print (AppData.shared.apiToken)
                            
                            //                            Se almacenan los datos del usuario logueado para usarlos posteriormente en otras poticiones o pantallas
                            if let profile = response?.resp{
                                AppData.shared.profile = profile
                            }
                            print (AppData.shared.profile)
                            
                            //                            Se pasa a la presentación de la pantalla home
                            if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeId"){
                                homeuser.modalPresentationStyle = .fullScreen
                                self.present(homeuser, animated: true, completion: nil)
                            }
                            //                            Si la la contraseña o el usuario no son válidos se retorna el mensaje de Datos invalidos por parte de la API
                        }else if response!.status == 20{
                            
                            self.alert(message:response!.msg, type: .actionSheet)
                            
                        }else if response!.status == 21{
                            
                            self.alert(message:response!.msg, type: .actionSheet)
                        }
                    }
                }
            }
        }
    }
    
    
    //    Función para mostrar alertas
    public func alert(message:String, type:UIAlertController.Style) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: type)
        
        let confirmAction = UIAlertAction(title: "Continuar", style: .default){
            action in
            //            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //Función para activar o desactivar la visibilidad de la contraseña
    @IBAction func viewPass(_ sender: Any){
        
        eyeBtn.isSelected = !eyeBtn.isSelected
        passwordTF.isSecureTextEntry.toggle()
        
    }
    
}


