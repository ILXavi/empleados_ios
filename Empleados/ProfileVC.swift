//
//  ProfileVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import UIKit
import AVFoundation

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var biographyTF: UITextView!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var logOutBtn: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var chargeBackground: UIView!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var editPhotoIV: UIImageView!
    @IBOutlet var headerTextView: UITextView!
    @IBOutlet var headerTextViewHeight: NSLayoutConstraint!
    
    
    let picker = UIImagePickerController()
    
    var response: Response?
    var localprofile: Employee?
    
    
    override func viewDidLoad() {
        
        print("CARGA LA VISTA PERFIL")
        self.navigationItem.title = "Perfil"
        self.logOutBtn?.layer.cornerRadius = 6
        editPhotoIV.layer.cornerRadius = editPhotoIV.frame.height / 2.0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        
//        Se cargan los datos de la persona que hizo login
        self.localprofile = AppData.shared.profile[0]
        self.nameLabel.text = self.localprofile?.name
        self.biographyTF.text = self.localprofile?.biography
        self.jobLabel.text = self.localprofile?.job
        self.nameLabel.text = self.localprofile?.name
        if let salary = self.localprofile?.salary{
            self.salaryLabel.text = "\(salary) €"
        }
        
        //        let fixedWidth = headerTextView.frame.size.width
        //        let newSize = headerTextViewHeight.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        //        headerTextViewHeight.constant = min(120, newSize.height)
    }
    
//    Función para seleccionar o tomar imagen de perfil
    @IBAction func buttonImageTapped(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = UIColor(named: "user")
        
        let camara = UIAlertAction(title: "Hacer foto", style: .default, handler: {(action) in
            self.picker.sourceType = .camera
            self.picker.cameraCaptureMode = .photo
            self.picker.allowsEditing = true
            self.picker.delegate = self
            self.present(self.picker, animated: true)
        })
        let galeria = UIAlertAction(title: "Seleccionar foto", style: .default, handler: {(action) in
            self.picker.sourceType = .photoLibrary
            self.picker.delegate = self
            self.picker.allowsEditing = true
            self.present(self.picker, animated: true)
        })
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel  , handler: {(action) in
            
        })
        alertController.addAction(camara)
        alertController.addAction(galeria)
        alertController.addAction(cancelar)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        imageProfile.image = image
        imageProfile.layer.borderColor = UIColor(named: "Blue app")?.cgColor
        imageProfile.layer.borderWidth = 3
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        
    }
    
    
//    Función para cerrar sesión
    @IBAction func buttonLogOutTapped(_ sender: Any){
 
        
        let alert = UIAlertController(title: "Aviso", message: "¿Desea cerrar sesión?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default){
            action in

        }
        
        let logOutAction = UIAlertAction(title: "Salir", style: .destructive){
            action in

            
            if let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginId"){
                
                login.modalPresentationStyle = .fullScreen
                self.present(login, animated: true, completion: nil)
            }
            
        }
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
