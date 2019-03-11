//
//  ApiListaController.swift
//  ApiLibreria
//
//  Created by dam on 20/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class ApiListaController: UITableViewController {

    var books = [Book]()
    let api = API()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        api.getBooks { (data:[Book], error:String) in
            self.books=data
            self.tableView.reloadData()
            print(data)
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(books[indexPath.row].id)
            api.deleteBook(id: books[indexPath.row].id!) { (data:String, error:String) in
                if (data=="OK"){
                    self.books.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                else{
                    print(error)
                }
            }
        } else if editingStyle == .insert {
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.nombre.text=books[indexPath.row].nombre
        cell.autor.text=books[indexPath.row].autor ?? "Desconocido"
        cell.editorial.text=books[indexPath.row].editorial
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
            case "AddBook":
                break
            case "editBook":
                guard let ViewControllerDestino = segue.destination as? LibroEdit else {
                    print("Error sin destino")
                    return
                }
                
                guard let CeldaElegida = sender as? TableViewCell else {
                    print("Error sin celda")
                    return
                }
                
                guard let indexPath = tableView.indexPath(for: CeldaElegida) else {
                    fatalError("Error celda no mostrada en el indice")
                }
                
                let book = books[indexPath.row]
                ViewControllerDestino.book = book
                break
            default:
                print("Unknown method \(String(describing: segue.identifier))")
        }
    }

    @IBAction func unwindToAnimalList(_ unwindSegue: UIStoryboardSegue) {
        guard let sourceViewController = unwindSegue.source as? LibroEdit, let book = sourceViewController.book else{
            return;
        }
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            api.updateBook(book: book) { (data:String, error:String) in
                print(error)
                self.books[selectedRow.row]=book
                self.tableView.reloadRows(at: [selectedRow], with: .none)
            }
        }
        else{
            let path = IndexPath(row: books.count,section: 0);
            
            api.addBook(book: book) { (data:String, error:String) in
                print (error)
                book.id = data
                self.books.append(book)
                self.tableView.insertRows(at: [path], with: .automatic)
            }
        }
    }

}
