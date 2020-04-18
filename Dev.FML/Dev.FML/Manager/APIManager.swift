//
//  APIManager.swift
//  Dev.FML
//
//  Created by Alejandro Espinoza on 17/04/20.
//  Copyright © 2020 Alejandro Espinoza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager{
    
    
    static let shared = APIManager()
    
    let baseURL = NSURL(string: BASE_URL)
    
    
    func requestServer(_ method: HTTPMethod,_ path: String,_ params:[String:Any]?,_ encoding:ParameterEncoding,_ completionHandler: @escaping (JSON) -> Void ){
        
        
        let url = baseURL!.appendingPathComponent(path)
        
        
        
        AF.request(url!, method: method, parameters: params, encoding:encoding, headers: nil).responseJSON{ response  in
            
            
            switch response.result{
                
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json)
                break
                
                
            case .failure:
                completionHandler(JSON.null)
                break
            }
            
        }
        
        
    }
    
    
    func iris(params : [String:Any]  ,completionHandler: @escaping (JSON) -> Void){
        
        let path = "api/iris/"
        
        
        requestServer(.post, path, params, JSONEncoding.default, completionHandler)
        
    }
}
