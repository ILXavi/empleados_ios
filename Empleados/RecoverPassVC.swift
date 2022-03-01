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
    @IBOutlet var logOutBtn: UIButton!
    
    
    var response: Response?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoveryBtn?.layer.cornerRadius = 6
        self.logOutBtn?.layer.cornerRadius = logOutBtn.frame.height / 2.0
        
    }
    
    @IBAction func recoverButtonTapped(_ sender: Any){
        
        if (recoveryEmailTF.text == ""){
            self.alert(message: "Debe introducir un email", type: .actionSheet)
        }else{
            
            //            Se recopilan los parametros
            let params : [String: Any] = [
                "email": recoveryEmailTF.text ?? ""
            ]
            print(params)
            
            //            Se envia a la API la petición para recuperar contraseña
            DataMapper.shared.recoverPassword(params: params) {
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
                            
                            //                            Petición validada y se muestra mensaje de envío al correo de la nueva contraseña
                        }else if response!.status == 1{
                            
                            print ("Correo enviado")
                            self.alert(message:response!.msg, type: .alert)
                            
                        }else if response!.status == 20{
                            print ("Usuario no registrado")
                            self.alert(message:response!.msg, type: .alert)
                            
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
    
    //    Función para cerrar pantalla modal
    @IBAction func closeModalScreen(_ sender:Any){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
