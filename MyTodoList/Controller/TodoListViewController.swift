//
//  ViewController.swift
//  MyTodoList
//
//  Created by User on 10/03/2020.
//  Copyright © 2020 naderkaabi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //var item = Item()
    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorngon"]
   // var itemsArray = [Item] ()
    
    
    let userdefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let item1 = Item()
//        item1.title = "Find Mikle"
//        item1.done = true
//        itemsArray.append(item1)
//        let item2 = Item()
//        item2.title = "Buy Eggos"
//        item1.done = true
//        itemsArray.append(item2)
//        let item3 = Item()
//        item3.title = "Destroy morgorngon"
//        item3.done = true
//        itemsArray.append(item3)
//        let item4 = Item()
//        item4.title = "new item"
//        item4.done = true
//        itemsArray.append(item4)
//        let item5 = Item()
//        item5.title = "call Jhon"
//        item5.done = true
//        itemsArray.append(item5)
        if let items = userdefaults.array(forKey: "ToDoItem") as? [String]  {
            itemArray = items
            
        }
        
    }
    
    
   //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        print(itemArray[indexPath.row])
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
       // tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        //let item = Item()
        
        let alert = UIAlertController(title: "Add New Item", message: "On your todo list", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (alert) in
            //what will hapen when user clicks the add Item button on our UIAlert
            print("Success!")
            print("at this time textFieldValue is: \(textField.text!) ")
            
            if textField.text! != "" {
               // item.title = textField.text!
                self.itemArray.append(textField.text!)
                self.userdefaults.set(self.itemArray, forKey: "ToDoItem")
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
    
}

