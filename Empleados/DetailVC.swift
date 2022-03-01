//
//  DetailVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 18/2/22.
//

import UIKit

class DetailVC: UIViewController{
    
    
    var employee: Employee?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var biographyLabel: UITextView!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var editProfileBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.renderUI()
    }
    
    //    Función para cargar los datos de la vista
    private func renderUI() {
        
        closeBtn.layer.cornerRadius = closeBtn.frame.height / 2.0
        nameLabel.text = employee?.name
        biographyLabel.text = employee?.biography
        jobLabel.text = employee?.job
        if let salary = employee!.salary{
            salaryLabel.text = "\(salary)  €"
            
        }
        
        //        Guardamos locamente los datos del empleado seleccionado para usarlos en actualizar empleado de ser necesario
        AppData.shared.selectedEmployee = employee
    }
    
    //    Funcion para cerrar la vista modal
    @IBAction func backToHome(_ sender:Any){
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

