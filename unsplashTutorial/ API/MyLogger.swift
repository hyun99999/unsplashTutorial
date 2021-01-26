//
//  MyLogger.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/26.
//

import Foundation
import Alamofire

final class MyLogger: EventMonitor {
    let queue = DispatchQueue(label: "MyLogger")
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestDidResume() called")
        debugPrint(request)
    }
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("MyLogger - request.didParseResponse() called")
    }
}
