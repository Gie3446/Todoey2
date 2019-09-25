//
//  ViewController.swift
//  Todoey2
//
//  Created by VIRGIE LYN JORDAN on 9/17/19.
//  Copyright © 2019 VIRGIE LYN JORDAN. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
   // var itemArray = ["Go to the supermarket", "Make dinner", "Take shower", "Continue on Swift lessons", "Go to bed"]
    
    var itemArray = [Item]()

    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let newItem = Item()
        newItem.title = "Go"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.title = "to"
        itemArray.append(newItem2)
        
        
        let newItem3 = Item()
        newItem3.title = "Go to supermarket"
        itemArray.append(newItem3)
        
        
        let newItem4 = Item()
        newItem4.title = "Go to supermarket"
        itemArray.append(newItem4)
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        itemArray = items
        
    }
    
    //MARK Create TableView DataSource Methods :
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating new cell thus wiping out accessory type associated into the cell as you scroll.
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoListCell")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let items = itemArray[indexPath.row]
        
        cell.textLabel?.text = items.title
        
        
        
        
//        if items.done == true {
//
//            cell.accessoryType = .checkmark
//
//        } else {
//
//            cell.accessoryType = .none
//        }
        
        //Using Ternary Operator to set cell's accessory type
        
        cell.accessoryType = items.done ? .checkmark : .none
        
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    //MARK Create TableView Delegate Methods :
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }
        
//        if (itemArray[indexPath.row].done) == false {
//
//            itemArray[indexPath.row].done = true
//        }
//
//        else {
//
//            itemArray[indexPath.row].done = false
//        }
        
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    @IBAction func AddItemBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //MARK - What happens when Add Item is pressed
            
//            self.itemArray.append(textField.text!)

            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
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

