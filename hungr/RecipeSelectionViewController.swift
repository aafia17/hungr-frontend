//
//  RecipeSelectionViewController.swift
//  hungr
//
//  Created by AA on 1/29/22.
//

import Foundation
import UIKit
import Alamofire


class RecipeSelectionViewController: UIViewController {
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var RecipeName: UILabel!
    @IBOutlet weak var RecipeCost: UILabel!
    @IBOutlet weak var TimeToMake: UILabel!
    @IBOutlet weak var LikeRecipe: UIButton!
    @IBOutlet weak var DislikeRecipe: UIButton!
    
    func json() -> String{
        return "json"
    }

    struct Rating: Encodable {
        let name: String;
        let rating: Double;
    }

    struct RequestBody: Encodable {
        let num_predictions: Int;
        let ratings: [Rating];
    }

    struct Ingredient: Decodable {
        let name: String;
        let price: Double;
        let quantity: String;
        let unit: String;
    }

    struct Recipe: Decodable {
        let description: String;
        let img: String;
        let ingredients: [Ingredient];
        let instructions: [String];
        let name: String;
        let source: String;
        let time: String;
        let score: Double?
    }

    struct ResponseBody: Decodable {
        let recipes: [Recipe];
    }
    
    var imageString: String = "https://www.budgetbytes.com/wp-content/uploads/2018/09/Italian-Orzo-Salad-plate.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: imageString)
        let data = try? Data(contentsOf: url!)
        RecipeImage.image = UIImage(data: data!)
        json2(callback: { responseBody in
            self.RecipeName.text = responseBody.recipes[0].name
        })
    }
    
    @IBAction func likeRecipeAction(_ sender: Any) {
        
    }
    
    @IBAction func dislikeRecipeAction(_ sender: Any) {
        
    }
    
    func updateRecipe() {
        
    }
    
    func json2(callback: @escaping((ResponseBody) -> ())) {
        let body = RequestBody(
            num_predictions: 10, ratings: []
        )
        print("here")
        AF.request("http://hungr.garrettgu.com/predict", method: .post, parameters: body, encoder: JSONParameterEncoder.default)
            .response { response in
                print(response.data)
                let resp = try! JSONDecoder().decode(ResponseBody.self, from: response.data!)
                print(resp.recipes)
                callback(resp)
                
            }
    }
}
