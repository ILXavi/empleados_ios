//
//  RegisterEmployeeVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import UIKit

class RegisterEmployeeVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var confirmPasswordTF: UITextField!
    @IBOutlet var salaryTF: UITextField!
    @IBOutlet var biographyTV: UITextView!
    @IBOutlet var jobSC: UISegmentedControl!
    @IBOutlet var registerBtn: UIButton!
    @IBOutlet var eyeBtn: UIButton!
    @IBOutlet var eyeRepeatBtn: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var noPermissionsView: UIView!
    
    var response: Response?
    var newEmployee: Employee?
    var job: String?
    var infoMessage: String? = "Encontramos algunos fallos en el formulario:\n"
    var field: String = ""
    
    //    Expresiones regulares para controlar el registro evitando que las comprobaciones deban ir hasta la API
    let nameRegEx = "^[A-ZÁÉÍÓÚ]{1}[a-zñáéíóú]+[\\s]+[A-ZÁÉÍÓÚ]{1}[a-zñáéíóú]{1,20}"
    let passRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}$"
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    let salaryRegEx = "^[0-9]+(?:[.][0-9]+)*$"
    let biographyRegEx = "[A-Za-z0-9.-_].{3,20}$"
    
    override func viewDidLoad() {
        
        print("VISTA REGISTRO")
        
        if AppData.shared.profile[0].job != "Empleado"{
            
            noPermissionsView.layer.isHidden = true
            
        }
        
        self.navigationItem.title = "Registrar empleado"
        self.registerBtn?.layer.cornerRadius = 6
        
        //        Control de longitud del campo nombre
        nameTF.addTarget(self, action: #selector(RegisterEmployeeVC.textFieldDidChange(_:)), for: .editingChanged)
        
        //        Agregamos un observer para controlar que el teclado no tape parte de la vista de registro
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //    Función para controlar longitud de text Field
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        if(nameTF.text!.count <= 50){
            field = nameTF.text!
        }else{
            nameTF.text = field
        }
    }
    
    //    Función para determinar las acciones al pulsar el boton registar
    @IBAction func registerButtonTapped (_ sender: Any){
        
        
        print("SE PULSA BOTON REGISTRO")
        
        //       Comprobamos si algun campo esta vacio
        if (nameTF.text == "" || emailTF.text == "" || passwordTF.text == "" || confirmPasswordTF.text == "" || salaryTF.text == "" || biographyTV.text == ""){
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
        
        //        Comprobamos si la contraseña cumple el patrón
        
        let isPasswordValid = isValidInput(toCheck: passwordTF.text!, regEx: passRegEx)
        
        if !isPasswordValid && passwordTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- La contraseña debe tener 6 caracteres, que incluyan minúsculas, mayúsculas y números."
        }
        
        //        Comprobamos si la contraseña y la confirmacion de contraseña son iguales
        
        
        if passwordTF.text != confirmPasswordTF.text!{
            self.infoMessage = "\(self.infoMessage!) \n- Las contraseñas no son iguales"
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
                "api_token": AppData.shared.apiToken,
                "name": nameTF.text ?? "",
                "email": emailTF.text ?? "",
                "password": passwordTF.text ?? "",
                "salary": Float(salaryTF.text!) ?? 0,
                "biography": biographyTV.text ?? "",
                "job": job ?? ""
            ]
            
            print (params)
                
                DataMapper.shared.register(params: params) {
                    response in
                    //                self.spinner.isHidden = false
                    
                    if response == nil {
                        // Error de conexión
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
                                
                                if let registerVerified = response?.msg{
                                    self.alert(message:registerVerified, type: .alert)
                                }
                                
                                //                            Dejamos los campos vacíos después del registro
                                self.nameTF.text = ""
                                self.emailTF.text = ""
                                self.passwordTF.text = ""
                                self.confirmPasswordTF.text = ""
                                self.salaryTF.text! = ""
                                self.biographyTV.text = ""
                                self.jobSC?.selectedSegmentIndex = UISegmentedControl.noSegment
                                
                                //                            Si la respuesta es estatus 11 quiere decir que ya existe un usuario registrado con ese email y debe cambiar el email para continuar con el registro
                            }else if response!.status == 11{
                                print ("Los datos no pasaron el validador")
                                
                                self.alert(message:"El correo ingresado ya se encuentra registrado", type: .alert)
                                
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
    
    // Función para controlar si se puede ver o no la contraseña escita en el campo
    
    @IBAction func viewPass(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender == eyeBtn{
            passwordTF.isSecureTextEntry.toggle()
        } else if sender == eyeRepeatBtn{
            confirmPasswordTF.isSecureTextEntry.toggle()
        }
        
    }
    
    //    Funciones para controlar que el teclado no se sobreponga sobre los campos del registro
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
