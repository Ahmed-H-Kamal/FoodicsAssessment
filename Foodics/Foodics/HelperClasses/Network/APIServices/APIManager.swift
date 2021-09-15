//
//  ApiManager.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//


import Alamofire
import UIKit

enum Error: String{
    case responseCouldNotBeParsed
    case generalError
    case failed
}
class ApiManager: BaseApiManager {
    
    class func makeApiCall(with url: String,
                           method: HTTPMethod = .post,
                           params: [String: Any] = [:],
                           headers: HTTPHeaders? = getAPIHeader(),
                           completion: @escaping ( _ result: Data?, _ error:Error?) -> ()) {
        if method == .get {
            let dataRequest = self.getDataRequest(url,
                                                  params: params,
                                                  method: .get,
                                                  encoding: URLEncoding.default,
                                                  headers: headers)
            self.executeDataRequest(dataRequest, with: completion)
        }
        else {
            let dataRequest = self.getDataRequest(url,
                                                  params: params,
                                                  method: method,
                                                  headers: headers)
            self.executeDataRequest(dataRequest, with: completion)
        }
    }
    
    private class func executeDataRequest(_ dataRequest: DataRequest,
                                          with completion: @escaping ( _ result: Data?, _ error:Error?) -> ())
    {
        dataRequest.validate(contentType: ["application/json"]).responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print("REQUEST:")
                    print(String(decoding: response.request?.httpBody ?? Data(), as: UTF8.self))
                    if let JSONString = String(data: response.data ?? Data(), encoding: String.Encoding.utf8){
                        print("RESPONSE: \(JSONString)")
                    }
                    completion(response.data, nil)
                    
                case .failure(let value):
                    print("RESPONSE ERROR: \(value)")
                    print(response)
                    completion(nil, Error.responseCouldNotBeParsed)
                }
            }
        }
    }
    
    class func getAPIHeader() -> HTTPHeaders {
        let header = ["Accept" : "application/json",
                      "Content-Type" : "application/json"]
        
        return HTTPHeaders.init(header)
    }
}

class BaseApiManager: NSObject {
    
    class func getDataRequest(_ url: String,
                              params: [String: Any] = [:],
                              method: HTTPMethod = .post,
                              encoding: ParameterEncoding = JSONEncoding.default,
                              headers: HTTPHeaders? = nil) -> DataRequest {
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 300
        let dataRequest = manager.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        
        return dataRequest
    }
    
}
