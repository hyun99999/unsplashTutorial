//
//  MyAlamofireManager.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/26.
//

import Foundation
import Alamofire

final class MyAlamofireManager {
    // 싱글턴 적용
    static let shared = MyAlamofireManager()
    
    //인터셉터 : api 호출 시 가로채서 중간에 공통 파라미터를 넣거나 토큰 인증을 하거나 등
    let intercepters = Interceptor(interceptors: [
    BaseInterceptor()
    ])
    
    // 쿠기 설정
//    let monitors =
    
    //세션 설정
    var session : Session
    private init() {
        session = Session(interceptor: intercepters )
    }
}
