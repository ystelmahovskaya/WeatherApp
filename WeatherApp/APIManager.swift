//
//  APIManager.swift
//  WeatherApp
//
//  Created by Yuliia Stelmakhovska on 2017-08-06.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void
enum APIResult <T> {
    case Success(T)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completionHandler: JSONCompletionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse:([String:AnyObject])->T?, completionHandler: (APIResult<T>)-> Void)
    
    
    init(sessionConfiguration: URLSessionConfiguration)
}

extension APIManager{
    
    func JSONTaskWith(request: URLRequest, completionHandler:  @escaping JSONCompletionHandler) -> JSONTask {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            //
            guard let HTTPResponse = response as? HTTPURLResponse else{
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Responce", comment: "")
                ]
                //SWANetworkingErrorDomain is a public variable from error manager
                let error = NSError(domain: SWANetworkingErrorDomain, code: 100, userInfo: userInfo)
                
                completionHandler(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error{
                    completionHandler(nil, HTTPResponse, error)
                }
            }
            else {
                switch HTTPResponse.statusCode {
                case 200:
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                        completionHandler(json, HTTPResponse, nil)
                    }catch let error as NSError{
                        completionHandler(nil, HTTPResponse, error)
                    }
                default:
                    print("response status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, parse:([String:AnyObject])->T?, completionHandler: (APIResult<T>)-> Void){
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
            guard let json = json else{
                if let error = error{
                    completionHandler(.Failure(error))
                }
                return
            }
            if let value = parse(json){
                completionHandler(.Success(value))
            }else {
                let error = NSError(domain: SWANetworkingErrorDomain, code: 200, userInfo: nil)
                completionHandler(.Failure(error))
            }
        }
        dataTask.resume()
    }
}
