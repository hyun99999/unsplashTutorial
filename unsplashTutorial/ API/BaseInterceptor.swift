//
//  BaseInterceptor.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/26.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    //
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() called")
        //헤더추가
        var request = urlRequest
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type" )
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField:"Accept")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        //응답에 대한 결과로 정상적인 작업이 되지 않는다면 여기서 설정 가능.
        print("BseInterceptor - retry() called")
        completion(.doNotRetry)
    }
}
