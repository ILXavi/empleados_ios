//
//  EditEmployeeVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import UIKit

class EditEmployeeVC: UIViewController{
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var salaryTF: UITextField!
    @IBOutlet var biographyTV: UITextView!
    @IBOutlet var jobSC: UISegmentedControl!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    
    var response: Response?
    var infoMessage: String? = "Encontramos algunos fallos en el formulario:\n"
    var job: String?
    var employeeId = AppData.shared.selectedEmployee?.id
    
    
    //    Expresiones regulares para controlar el registro evitando que las comprobaciones deban ir hasta la API
    let nameRegEx = "^[A-ZÁÉÍÓÚ]{1}[a-zñáéíóú]+[\\s]+[A-ZÁÉÍÓÚ]{1}[a-zñáéíóú]{1,20}"
    let passRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}$"
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    let salaryRegEx = "^[0-9]+(?:[.][0-9]+)*$"
    let biographyRegEx = "[A-Za-z0-9.-_].{3,20}$"
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "Editar empleado"
        self.editBtn?.layer.cornerRadius = 6
        self.backBtn?.layer.cornerRadius = backBtn.frame.height / 2.0
        
        //        Se cargan los datos del perfil seleccionado en los textfield
        nameTF.text = AppData.shared.selectedEmployee?.name
        emailTF.text = AppData.shared.selectedEmployee?.email
        biographyTV.text = AppData.shared.selectedEmployee?.biography
        if let salary = AppData.shared.selectedEmployee?.salary{
            salaryTF.text = "\(salary)"
        }
        if AppData.shared.selectedEmployee?.job == "Direccion"{
            jobSC.selectedSegmentIndex = 0
        }else if AppData.shared.selectedEmployee?.job == "RRHH"{
            jobSC.selectedSegmentIndex = 1
        }else if AppData.shared.selectedEmployee?.job == "Empleado"{
            jobSC.selectedSegmentIndex = 2
        }
        
    }
    
    //    Función para cerrar la pantalla modal
    @IBAction func back(_ sender:Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    //    Función para determinar las acciones al pulsar el boton registar
    @IBAction func updateButtonTapped (_ sender: Any){
        
        
        print("SE PULSA BOTON ACTUALIZAR")
        
        //       Comprobamos si algun campo esta vacio
        if (nameTF.text == "" || emailTF.text == "" || salaryTF.text == "" || biographyTV.text == ""){
            self.infoMessage = "\(self.infoMessage!) \n- Complete todos los campos."
        }
        
        //        Comprobamos si el nombre cumple el patrón
        
        let isNameValid = isValidInput(toCheck: nameTF.text!, regEx: nameRegEx)
        
        if !isNameValid && nameTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- Ingrese nombre y apellido iniciando en mayúsculas (máx. 50 caracteres)."
        }
        
        //        Comprobamos si el email cumple el patrón
        
        let isEmailValid = isValidInput(toCheck: emailTF.text!, regEx: emailRegEx)
        
        if !isEmailValid && emailTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- Ingrese un correo válido."
        }
        
        
        //        Comprobamos si el salario cumple el patrón
        
        let isSalaryValid = isValidInput(toCheck: salaryTF.text!, regEx: salaryRegEx)
        
        if !isSalaryValid && salaryTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- Debe ingresar un valor numérico como salario, use punto (.) para separar decimales de ser necesario."
        }
        
        //        Comprobamos si la biografía cumple el patrón
        
        let isBiographyValid = isValidInput(toCheck: biographyTV.text!, regEx: biographyRegEx)
        
        if !isBiographyValid && biographyTV.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- Biografía entre 10 - 180 caracteres."
        }
        
        //      Comprobamos si se ha seleccionado el tipo de cargo y cual es
        
        if jobSC?.selectedSegmentIndex == 0{
            job = "Direccion"
        }
        else if jobSC?.selectedSegmentIndex == 1 {
            job = "RRHH"
        } else if jobSC?.selectedSegmentIndex == 2{
            job = "Empleado"
        }else{
            self.infoMessage = "\(self.infoMessage!) \n- Seleccione el cargo del trabajador."
            
        }
        
        
        // Mostramos alert con todos los mensajes obtenidos
        if infoMessage != "Encontramos algunos fallos en el formulario:\n"{
            self.alert(message:infoMessage!, type: .actionSheet)
            infoMessage = "Encontramos algunos fallos en el formulario:\n"
        }else{
            
            //      Se alistan los parametros y se envia la petición
            
            let params : [String: Any] = [
                "id": String((AppData.shared.selectedEmployee?.id)!) ,
                "api_token": AppData.shared.apiToken,
                "name": nameTF.text ?? "",
                "email": emailTF.text ?? "",
                "salary": Float(salaryTF.text!) ?? 0,
                "biography": biographyTV.text ?? "",
                "job": job ?? ""
            ]
            
            print (params)
            
            DataMapper.shared.editProfile(params: params) {
                response in
                
                if response == nil {
                    self.alert(message: "Upss! ha ocurrido un error, intentalo más tarde.", type: .alert)
                }
                else {
                    DispatchQueue.main.async {
                        
                        self.response = response
                        
                        //                        Si el estatus es 0, no hubo conexión con la API
                        if response?.status == 0{
                            print ("ERROR")
                            self.alert(message: "Upss! ha ocurrido un error, intentalo más tarde.", type: .alert)
                            
                            //                            Si el estatus es 1 hubo conexión y respuesta por parte de la API (Registro correcto)
                        }else if response!.status == 1{
                            
                            print ("Usuario registrado correctamente")
                            
                            //                            Dejamos los campos vacíos después de la actualización
                            self.nameTF.text = ""
                            self.emailTF.text = ""
                            self.salaryTF.text! = ""
                            self.biographyTV.text = ""
                            self.jobSC?.selectedSegmentIndex = UISegmentedControl.noSegment
                            
                            
                            let alert = UIAlertController(title: "Empleado actualizado correctamente", message: nil, preferredStyle: .alert)
                            
                            let confirmAction = UIAlertAction(title: "Continuar", style: .default){
                                action in
                                
                                if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeId"){
                                    homeuser.modalPresentationStyle = .fullScreen
                                    self.present(homeuser, animated: true, completion: nil)
                                }
                            }
                            alert.addAction(confirmAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            //                            Si la respuesta es estatus 11 quiere decir que ya existe un usuario registrado con ese email y debe cambiar el email para continuar con el registro
                        }else if response!.status == 11{
                            print ("Los datos no pasaron el validador")
                            
                            if let editVerified = response?.msg{
                                self.alert(message:editVerified, type: .alert)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //    Función para controlar todos los alert y el tipo de presentación que tendrán
    
    public func alert(message:String, type:UIAlertController.Style) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: type)
        
        let confirmAction = UIAlertAction(title: "Continuar", style: .default){
            action in
            //            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //    Función para controlar si los datos ingresados cumplen con la RegEx dependiendo del campo y el patrón
    
    public func isValidInput(toCheck: String, regEx: String) -> Bool {
        
        var returnValue = true
        
        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let nsString = toCheck as NSString
            let results = regex.matches(in: toCheck, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}
