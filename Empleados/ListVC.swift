//
//  EmployeesListVC.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var employeeList: UITableView!
    @IBOutlet var noPermissionsView: UIView!
    
    var response: Response?
    
    override func viewDidLoad() {
        self.navigationItem.title = "Listar empleados"
        self.spinner.isHidden = true
        self.spinner.hidesWhenStopped = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        //        Se alista el parametro apitoken almacenado en el momento del login
        
        let params : [String: Any] = [
            "api_token": String(AppData.shared.apiToken)
        ]
        
        print(params)
        
        if AppData.shared.profile[0].job != "Empleado"{
            
            noPermissionsView.layer.isHidden = true
            
            //            Se lanza la petición para cargar la lista de empleados de acuerdo a los permisos
            DataMapper.shared.list(params: params) {
                response in
                
                //              Si hay error en la conexión
                if response == nil {
                    
                    print("ERROR EN LA CONEXION")
                    
                    let alert = UIAlertController(title: "Upss! ha ocurrido un error", message: nil, preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "Continuar", style: .default){
                        action in
                    }
                    alert.addAction(confirmAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else {
                    
                    DispatchQueue.main.async {
                        
                        self.spinner.stopAnimating()
                        self.response = response
                        self.employeeList.reloadData()
                        
                        if response?.status == 0{
                            
                            let alert = UIAlertController(title: "Upss! ha ocurrido un error", message: nil, preferredStyle: .alert)
                            
                            let confirmAction = UIAlertAction(title: "Continuar", style: .default){
                                action in
                            }
                            alert.addAction(confirmAction)
                            self.present(alert, animated: true, completion: nil)
                            
                        }else if response!.status == 1{
                            print ("Listado")
                            print (AppData.shared.apiToken)
                            
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.resp?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCellId", for: indexPath) as? ListCell {
            cell.employee = response?.resp?[indexPath.row]
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se ha pulsado la celda \(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailView = storyboard?.instantiateViewController(identifier:"EmployeeViewId") as? DetailVC {
            
            detailView.employee = response?.resp?[indexPath.row]
            detailView.modalPresentationStyle = .automatic
            self.present(detailView, animated: true, completion: nil)
            
        }
    }
}
