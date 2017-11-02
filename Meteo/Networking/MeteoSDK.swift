//
//  MeteoSDK.swift
//  Meteo
//
//  Created by Leo Marcotte on 24/10/2017.
//  Copyright © 2017 Leo Marcotte. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RealmSwift


func getWeather(for cityName: String, completion: @escaping (_ error: NSError?) -> Void) {
    
    let params = [
        "q": cityName,
        "appId": "XXXXXXXXXXXXXXXXXX",
    ]
    
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    
    _ = SessionManager.default.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        if let error = response.error {
            completion(error as NSError)
        } else if let data = response.data {
            let json = JSON(data: data)
            if json == JSON.null {
                completion(NSError(domain: "com.leomarcotte.meteo", code: 0, userInfo: [NSLocalizedDescriptionKey : "Empty JSON Data"]))
                return
            }
            do {
                let code = json["cod"].intValue
                if let message = json["message"].string, code != 200 {
                    completion(NSError(domain: "api.openweathermap.org", code: code, userInfo: [NSLocalizedDescriptionKey : message]))
                    return
                }
                
                let realm = try Realm()
                let c = City()
                c.id = json["id"].stringValue
                c.name = json["name"].stringValue
                c.humidity = json["main"]["humidity"].doubleValue
                c.pressure = json["main"]["pressure"].doubleValue
                c.temperature = json["main"]["temp"].doubleValue
                c.sunset = Date(timeIntervalSince1970: json["sys"]["sunset"].doubleValue)
                c.sunrise = Date(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue)
                c.latitude = json["coord"]["lat"].doubleValue
                c.longitude = json["coord"]["lon"].doubleValue
                
                try realm.write {
                    realm.add(c, update: true)
                }
            } catch let error as NSError {
                completion(error)
            }
        } else {
            completion(NSError(domain: "com.leomarcotte.meteo", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data received is not JSON"]))
        }

    }
}
