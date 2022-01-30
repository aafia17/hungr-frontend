//
//  IngredientSelectionViewController.swift
//  hungr
//
//  Created by AA on 1/29/22.
//

import Foundation
import UIKit

class IngredientSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    var ingredients: [String] = ["Chicken", "Garlic", "Spinach"]
    @IBOutlet weak var IngredientList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IngredientList.delegate = self
        IngredientList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IngredientList.dequeueReusableCell(withIdentifier: "IngredientListTextCell", for: indexPath as IndexPath)
        let row = indexPath.row
        let currentIngredient = ingredients[row]
        cell.textLabel?.text = currentIngredient
        return cell
    }

}
