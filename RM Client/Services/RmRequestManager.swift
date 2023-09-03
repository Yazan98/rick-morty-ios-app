//
//  RmRequestManager.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation
import Alamofire

public final class RmRequestManager {
    
    public static let shared = RmRequestManager()
    
    private init() {}
    
    public func onExecuteSingleRequest<Response: Codable>(
        requestInfo: RmRequestInfo,
        responseType: Response.Type,
        onSuccessResponse: @escaping (Response) -> Void,
        onErrorResponse: @escaping (Error) -> Void
    ) {
        requestInfo.dispatchQueue.async {
            AF.request(
                requestInfo.requestUrl,
                method: self.getRequestMethod(method: requestInfo.requestMethod),
                parameters: self.getRequestParams(request: requestInfo.queryParams ?? [:])
            ).responseDecodable(of: responseType.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let response):
                        onSuccessResponse(response)
                    case .failure(let error):
                        onErrorResponse(error)
                    }
                }
            }
        }
    }
    
    public func onExecuteListRequest<Response: Codable>(
        requestInfo: RmRequestInfo,
        responseType: [Response].Type,
        onSuccessResponse: @escaping ([Response]) -> Void,
        onErrorResponse: @escaping (Error) -> Void
    ) {
        requestInfo.dispatchQueue.async {
            AF.request(
                requestInfo.requestUrl,
                method: self.getRequestMethod(method: requestInfo.requestMethod),
                parameters: self.getRequestParams(request: requestInfo.queryParams ?? [:]),
                encoding: URLEncoding(destination: .queryString) as! ParameterEncoder as! ParameterEncoding
            ).responseDecodable(of: responseType.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let response):
                        onSuccessResponse(response)
                    case .failure(let error):
                        onErrorResponse(error)
                    }
                }
            }
        }
    }
    
    private func getRequestParams(request: [String: String]) -> Parameters {
        if request.isEmpty {
            return [:]
        }
        
        var requestParams: Parameters = Parameters()
        request.forEach { (key: String, value: String) in
            requestParams.updateValue(value, forKey: key)
        }
        
        return requestParams
    }
    
    private func getRequestMethod(method: RmRequestMethod) -> HTTPMethod {
        if method == .get {
            return .get
        } else if method == .post {
            return .post
        } else {
            return .delete
        }
    }
    
    private func getApplicationRequestsHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = ["Authorization": "token Access Token"]
        headers.add(name: "Content-Type", value: "application/json")
        return headers
    }
    
}
