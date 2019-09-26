//
//  ViewController.swift
//  Todoey2
//
//  Created by VIRGIE LYN JORDAN on 9/17/19.
//  Copyright © 2019 VIRGIE LYN JORDAN. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }
    
    //MARK Create TableView DataSource Methods :
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating new cell thus wiping out accessory type associated into the cell as you scroll.
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoListCell")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let items = itemArray[indexPath.row]
        
        cell.textLabel?.text = items.title
        
        
        //Using Ternary Operator to set cell's accessory type
        
        cell.accessoryType = items.done ? .checkmark : .none
        
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    //MARK Create TableView Delegate Methods :
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    @IBAction func AddItemBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //MARK - What happens when Add Item is pressed
            


            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
  //          self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            
        }
        
        alert.addTextField { (alertTextfield) in
            
            alertTextfield.placeholder = "Create new item"
            
            textField = alertTextfield
           
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            
        let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        
        }
        catch {
            
            print("There is an error encoding itemArray, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
           
            do {
                
            itemArray = try decoder.decode([Item].self, from: data)
                
            }
            
            catch {
                
                print("Error decoding item array, \(error)")
                
            }
        }
        
    }

}
