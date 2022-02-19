//
//  ProfileVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import UIKit

class ProfileVC: UIViewController{
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var biographyTF: UITextView!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var logOutBtn: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var chargeBackground: UIView!
    
    var response: Response?
    var localprofile: Employee?
    
    override func viewDidLoad() {
        self.navigationItem.title = "Perfil"
        self.logOutBtn?.layer.cornerRadius = 6
        
        print("CARGA LA VISTA PERFIL")
        
        let params : [String: Any] = [
            "api_token": String(AppData.shared.apiToken)
        ]
        
        print(params)
        DataMapper.shared.getProfile(params: params) {
            response in

            if response == nil {
                // Error de conexión
                print("ERROR EN LA CONEXION")
            }
            else {
                DispatchQueue.main.async {
                    
                    self.spinner?.removeFromSuperview()
                    self.chargeBackground?.isHidden = true
                    self.response = response
                    
                    if response?.status == 0{
                        
                        print ("ERROR")
                        
                    }else if response!.status == 1{
                        
                        if let profile = response?.resp{
                            AppData.shared.profile = profile
                            self.localprofile = AppData.shared.profile[0]
                        }
                        
                        print("TENEMOS DATOS")
                        self.nameLabel.text = self.localprofile?.name
                        self.biographyTF.text = self.localprofile?.biography
                        if let salary = self.localprofile?.salary{
                            self.salaryLabel.text = "\(salary) €"
                        }
                        self.jobLabel.text = self.localprofile?.job
                    }
                }
            }
        }
        
    }
    
    @IBAction func buttonLogOutTapped(_ sender: Any){
        AppData.shared.apiToken = ""
        if let login = storyboard?.instantiateViewController(withIdentifier: "LoginId"){
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: true, completion: nil)
        }
        
    }
    
    
}
