//
//  ViewController.swift
//  Todoey2
//
//  Created by VIRGIE LYN JORDAN on 9/17/19.
//  Copyright © 2019 VIRGIE LYN JORDAN. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
    var itemArray = ["Go to the supermarket", "Make dinner", "Take shower", "Continue on Swift lessons", "Go to bed"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK Create TableView DataSource Methods :
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    //MARK Create TableView Delegate Methods :
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func AddItemBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //MARK - What happens when Add Item is pressed
            
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextfield) in
            
            alertTextfield.placeholder = "Create new item"
            
            textField = alertTextfield
           
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}

