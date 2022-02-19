//
//  RecoverPassVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 7/2/22.
//

import UIKit

class RecoverPassVC: UIViewController {
    
    @IBOutlet var recoveryEmailTF: UITextField!
    @IBOutlet var recoveryBtn: UIButton!
    
    var response: Response?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoveryBtn?.layer.cornerRadius = 6
        
    }
    
    @IBAction func recoverButtonTapped(_ sender: Any){
        
        if (recoveryEmailTF.text == ""){
            self.alert(message: "Debe introducir un email")
        }else{
            let params : [String: Any] = [
                "email": recoveryEmailTF.text ?? ""
            ]
            
            print(params)
            DataMapper.shared.recoverPassword(params: params) {
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
                            
                            print ("Correo enviado")
                            self.alert(message:response!.msg)
                            
                        }else if response!.status == 20{
                            print ("Usuario no registrado")
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
    
}
