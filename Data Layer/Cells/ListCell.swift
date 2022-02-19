//
//  ListCell.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 11/2/22.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    
    
    var employee: Employee? {
        didSet { renderUI() }
    }
    
    private func renderUI() {
        guard let employee = employee else {return}
        self.nameLabel!.text =  self.employee?.name
        self.jobLabel!.text = self.employee?.job
        if let salary = employee.salary {
            self.salaryLabel!.text = "\(salary) €"
        }
    }
    
}

