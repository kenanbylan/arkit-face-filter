//
//  WebService.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Kenan Baylan on 28.12.2022.
//

import Foundation




var sharedApiManager = WebService()

struct WebService  {
    
    let baseUrl = "http://10.125.14.115:3000"
    //10.125.14.115
    
    /*
     
     func RequestExample(completion: @escaping(Result<[Contact],ApiStatus>) -> Void) {
     
     let urlString = baseUrl + "/contacts"
     
     
     guard let url = URL(string: urlString) else {
     completion(.failure(.badUrl))
     return
     }
     
     var request = URLRequest(url: url)
     request.httpMethod = "GET"
     request.addValue("application/json", forHTTPHeaderField: "Accept")
     URLSession.shared.dataTask(with: request) { data, response, error in
     guard let data = data , error == nil else {
     completion(.failure(.noData))
     return
     }
     
     guard let responseJson = try? JSONDecoder().decode([Contact].self, from: data) else {
     completion(.failure(.dataParseJson))
     print("error")
     return
     }
     
     
     //closure
     completion(.success(responseJson))
     
     //print(responseJson[0])
     //print("responseJson : ",responseJson)
     
     
     }.resume()
     }
     
     */
    
}

enum ApiStatus : Error {
    case badUrl
    case noData
    case dataParseJson
}
