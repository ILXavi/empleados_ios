//
//  RegisterEmployeeVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import UIKit

class RegisterEmployeeVC: UIViewController{
    
    @IBOutlet var nameTF: UITextField?
    @IBOutlet var emailTF: UITextField?
    @IBOutlet var passwordTF: UITextField?
    @IBOutlet var salaryTF: UITextField?
    @IBOutlet var biographyTF: UITextField?
    @IBOutlet var jobSC: UISegmentedControl?
    @IBOutlet var registerBtn: UIButton?
    
    var newEmployee: Employee?
    var job: String?
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "Registrar empleado"
        self.registerBtn?.layer.cornerRadius = 6
    }
    
    @IBAction func jobSelected(_ sender: Any) {
        if jobSC?.selectedSegmentIndex == 0{
            job = "Direccion"
        }
        else if jobSC?.selectedSegmentIndex == 1 {
            job = "RRHH"
        } else {
            job = "Empleado"
        }
    }
    
    var nombre: String?
    @IBAction func registerButtonTapped (_ sender: Any){
        
        let nname : String = nameTF?.text ?? "Sin nombre"
        newEmployee?.name = nname
        
//        if let name = nameTF?.text{
//            nombre = name
//            newEmployee?.name = nombre
//        }
//        if let email = emailTF?.text{
//            newEmployee?.email = email
//        }
//        if let password = passwordTF?.text{
//            newEmployee?.password = password
//        }
//        if let salary = salaryTF?.text{
//            newEmployee?.salary = Int(salary)!
//        }
//        if let biography = biographyTF?.text{
//            newEmployee?.biography = biography
//        }
//        if jobSC?.selectedSegmentIndex == 0{
//            newEmployee?.job = "Direccion"
//        }
//        else if jobSC?.selectedSegmentIndex == 1 {
//            newEmployee?.job = "RRHH"
//        } else {
//            newEmployee?.job = "Empleado"
//        }
        print(nombre)
        
    }
    
}
