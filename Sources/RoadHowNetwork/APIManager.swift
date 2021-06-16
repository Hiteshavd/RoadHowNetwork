//
//  File.swift
//  
//
//  Created by Hitesh Vaghasiya on 15/06/21.
//

import Foundation
import Alamofire

public func RHNetworkCall(
    url : URLConvertible,
    method: HTTPMethod,
    parameters: Parameters? = nil,
    headers: HTTPHeaders? = nil,
    completion: @escaping (HTTPURLResponse?) -> Void){
    
    print(url)
    print(parameters as Any)
    print(headers as Any)
    
    AF.request(url, method: method, parameters: parameters , headers: headers).responseJSON { (response) in
        print(response)
        completion(response.response)
    }
}
public func RHNetworkCallwithFilesUpload(
            url : URLConvertible,
            method: HTTPMethod,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            files: [categoryData],
            completion: @escaping (HTTPURLResponse?) -> Void) {
    AF.upload(multipartFormData: { (multipartFormData) in
        for (key, value) in parameters ?? [:]{
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
        }
        for file in files {
            multipartFormData.append(file.fileData, withName: file.paramName, fileName: file.fileName, mimeType: file.mimeType)
        }
        
    }, to: url, method: method, headers: headers).responseJSON { (response) in
        print(response)
        completion(response.response)
    }


}
