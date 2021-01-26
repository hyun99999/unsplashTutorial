//
//  MySearchRouter.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/26.
//

import Foundation
import Alamofire

//검색 관련 api
enum MySearchRouter: URLRequestConvertible {
    case searchPhotos(term: String)
    case searchUsers(term: String)
    //클로저. return 의 값이 baseURL이다.
    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchPhotos, .searchUsers:
            return .get
        }
        //아래와 같이 분기처리도 가능.
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
    }
    //엔드포인트 설정.
    var endPoint: String {
        switch self {
        case .searchPhotos: return "photos/"
        case .searchUsers: return "users/"
        }
    }
    //switch 문으로 공통 파라미터를 설정할 수도 있다.
    var parameters : [String:String] {
        switch self {
        case let .searchUsers(term), let .searchPhotos(term) :
            return ["query":term]
        }
    }
    //api 호출 시 발동되는 부분.
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        print("MySearchRouter - asURLRequest() url: \(url)")
        
        var request = URLRequest(url: url)
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request
        )
//        switch self {
//                case let .get(parameters):
//                    request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//                case let .post(parameters):
//                    request = try JSONParameterEncoder().encode(parameters, into: request)
//                }
                
                return request
    }
}

