//
//  RecoverPassVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 7/2/22.
//

import UIKit

class RecoverPassVC: UIViewController {
    
    @IBOutlet var recoveryEmailTF: UITextField?
    @IBOutlet var recoveryBtn: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoveryBtn?.layer.cornerRadius = 6
//        self.recoveryEmailTF?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named:"user_light")!] )
        
    }
    
//    @IBAction func buttonMapTapped(_ sender: Any){
//        if let map = storyboard?.instantiateViewController(withIdentifier: "MassageProfileFromUser"){
//            map.modalPresentationStyle = .fullScreen
//            self.present(map, animated: true, completion: nil)
//        }
//
//    }
    
}
