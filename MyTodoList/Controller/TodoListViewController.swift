//
//  ViewController.swift
//  MyTodoList
//
//  Created by User on 10/03/2020.
//  Copyright © 2020 naderkaabi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    

    var itemArray = [Item] ()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        let item1 = Item()
//        item1.title = "Find Mikle"
//        itemArray.append(item1)
//
//        let item2 = Item()
//        item2.title = "Buy Eggos"
//        itemArray.append(item2)
//
//        let item3 = Item()
//        item3.title = "Destroy Demogorgon"
//        itemArray.append(item3)
        
        
        // copy the save items in the UserDefaults to itemArray
       
        itemArray = getItems()!
        

    }
    
    
   //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        print(itemArray[indexPath.row].title)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
            
        }
        
        return cell
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done =   !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    @objc
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "On your todo list", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (alert) in
            //what will hapen when user clicks the add Item button on our UIAlert
            print("Success!")
            print("at this time textFieldValue is: \(textField.text!) ")
            
            if textField.text! != "" {
                let newItem = Item()
                newItem.title = textField.text!
                print("Here the new item get its property")
                print(newItem.title)
                print(newItem.done)
                
               
                self.itemArray.append(newItem)
                print("here we getting values of the itemArray itself")
                print(self.itemArray[self.itemArray.count - 1].title)
                print(self.itemArray[self.itemArray.count - 1].done)
                
                // this one works for just array of string
                //self.defaults.set(self.itemArray, forKey: "NewToDoListArray")
                
                // This Method of using below declared saveItems function works perfectly
                self.saveItems(self.itemArray)
                
                self.tableView.reloadData()
            
            }
            
        }
        
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print("at this time textFieldValue is not yet bonded")
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    
    func saveItems(_ list:[Item]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey:"NewToDoListArray")
        UserDefaults.standard.synchronize()
    }
    func getItems() -> [Item]? {
        if let data = UserDefaults.standard.value(forKey:"NewToDoListArray") as? Data {
            let decodedItems = try? PropertyListDecoder().decode([Item].self, from: data)
            return decodedItems
        }
        return nil
    }
    
}

