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
        var name: String;
        var rating: Double;
    }

    struct RequestBody: Encodable {
        var num_predictions: Int;
        var ratings: [Rating];
    }

    struct Ingredient: Decodable {
        var name: String;
        var price: Double?;
        var quantity: String;
        var unit: String;
    }

    struct Recipe: Decodable {
        var description: String;
        var img: String;
        var ingredients: [Ingredient];
        var instructions: [String];
        var name: String;
        var source: String;
        var time: String;
        var score: Double?
    }

    struct ResponseBody: Decodable {
        var recipes: [Recipe];
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
        json2(callback:{ responseBody in
            self.TimeToMake.text = responseBody.recipes[0].time
        })
        // hello me?
        json2(callback: { responseBody in
            var c = 0.0;
            for i in responseBody.recipes[0].ingredients{
                c += i.price ??  0
            }
            self.RecipeCost.text = String(format: "%f.1", c)
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
                //print(response.data)
                let resp = try! JSONDecoder().decode(ResponseBody.self, from: response.data!)
                //print(resp.recipes)
                callback(resp)
                
            }
    }
}
