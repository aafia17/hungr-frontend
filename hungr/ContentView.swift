//
//  ContentView.swift
//  Shared
//
//  Created by Vincent Cacciatore on 1/29/22.
//

import SwiftUI
import Alamofire

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
}

struct ResponseBody: Decodable {
    let recipes: [Recipe];
}

func json2() ->String{
    let body = RequestBody(
        num_predictions: 10, ratings: []
    )
    AF.request("http://hungr.garrettgu.com/predict", method: .post, parameters: body, encoder: JSONParameterEncoder.default)
        .response { response in
            let resp = try! JSONDecoder().decode(ResponseBody.self, from: response.data!)
            print(resp.recipes)
        }
    return "k"
}
