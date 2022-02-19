//
//  DetailVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 18/2/22.
//

import UIKit

class DetailVC: UIViewController{
    
//    var response: Response?
    var employee: Employee?
//    var delegate: DetailViewDelegate?
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var biographyLabel: UITextView!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var closeBtn: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.renderUI()
        }
       
    private func renderUI() {
    
        closeBtn.layer.cornerRadius = closeBtn.frame.height / 2.0
        nameLabel.text = employee?.name
        biographyLabel.text = employee?.biography
        jobLabel.text = employee?.job
        if let salary = employee!.salary{
            salaryLabel.text = "\(salary)  €"
            
        }
     
    }
    
    @IBAction func backToHome(_ sender:Any){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
   
}

