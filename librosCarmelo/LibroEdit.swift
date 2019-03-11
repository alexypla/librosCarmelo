//
//  LibroEdit.swift
//  librosCarmelo
//
//  Created by dam on 5/3/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class LibroEdit: UIViewController,UITextFieldDelegate {
    
    var book:Book?
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var isbnText: UITextField!
    @IBOutlet weak var autorText: UITextField!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var editorial: UITextField!
    @IBOutlet weak var precio: UITextField!
    @IBOutlet weak var edicion: UITextField!
    @IBOutlet weak var ejemplares: UITextField!
    var editMode=false
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreText.delegate=self
        isbnText.delegate=self
        if let b = book{
            nombreText.text=b.nombre
            isbnText.text=b.isbn
            autorText.text=b.autor
            editorial.text=b.editorial
            precio.text=b.precio
            edicion.text=b.edicion
            ejemplares.text=b.ejemplares
            self.title="Editar libro"
            labelTitle.text="Editar Libro"
            editMode=true
        }
        updateSave()
    }

    
    @IBAction func cancel(_ sender: Any) {
        if (editMode){
            navigationController?.popViewController(animated: true)
        }
        else{
            dismiss(animated: true, completion: nil)
        }
    }
    func updateSave(){
        let title = nombreText.text ?? ""
        let isbn = isbnText.text ?? ""

        saveBtn.isEnabled = (title.isEmpty || isbn.isEmpty || isbn.count < 3 || title.count < 3 ? false : true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateSave()
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSave()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if editMode == false{
            book = Book(nombre: nombreText.text!, isbn: isbnText.text!)
        }
        book!.nombre = nombreText.text!
        book!.editorial = editorial.text!
        book!.autor = autorText.text
        book!.precio = precio.text!
        book!.ejemplares = ejemplares.text!
        book!.edicion = edicion.text!
        book!.isbn = isbnText.text!

    }
}
