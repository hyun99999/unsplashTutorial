//
//  BaseInterceptor.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/26.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() called")
        //헤더추가
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type" )
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField:"Accept")
        
        //공통 파라미터 추가
//        var dictionary = [String:String]()
//        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
//        do {
//            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
//        } catch {
//            print(error)
//        }
//        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        //응답에 대한 결과로 정상적인 작업이 되지 않는다면 여기서 설정 가능.
        print("BseInterceptor - retry() called")
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        //statusCode 가 있다면 즉, 에러가 발생했다면 notificationcenter 에서 statuscode 라는 key 를 가진 딕셔너리로 statusCode 를 전송.
        let data = ["statusCode" : statusCode]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: data)
        completion(.doNotRetry)
    }
}
