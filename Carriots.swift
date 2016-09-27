//
//  Carriots.swift
//
//  Created by Christian Escalante on 26/9/16.
//  Copyright © 2016 indestim. All rights reserved.
//

import Foundation

class Carriots {
    let api_url = "http://api.carriots.com/streams"
    var api_key: String = ""
    var device: String = ""
    
    init(api_key: String, device: String){
        self.api_key = api_key
        self.device = device
    }
    
    func send_stream(_ payload: Dictionary<String, AnyObject>){
        let url = URL(string: api_url)
        var request = URLRequest(url: url!)
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        
        request.addValue(self.api_key, forHTTPHeaderField: "carriots.apikey")
        
        do {
            let data = ["protocol":"v2", "device":self.device, "at":"now", "data":payload] as [String : Any]
            let jsondata = try JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = jsondata
        } catch {
            print(error)
            request.httpBody = nil
        }
        
        let task = session.dataTask(with: request) {data, response, error in
            guard error == nil
                else
            {
                return
            }
            
            let strData = String(data: data!, encoding: String.Encoding.utf8)
            print("Body: \(strData)")
            let json: NSDictionary?
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? NSDictionary
            } catch let dataError {
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                print(dataError)
                let jsonStr = String(data: data!, encoding: String.Encoding.utf8)
                print("Error could not parse JSON: '\(jsonStr)'")
                // return or throw?
                return
            }
            
            // The JSONObjectWithData constructor didn't return an error. But, we should still
            // check and make sure that json has a value using optional binding.
            if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                let success = parseJSON["success"] as? Int
                print("Success: \(success)")
            }
            else {
                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = String(data: data!, encoding: String.Encoding.utf8)
                print("Error could not parse JSON: \(jsonStr)")
            }
            
        }
        task.resume()
    }
}
