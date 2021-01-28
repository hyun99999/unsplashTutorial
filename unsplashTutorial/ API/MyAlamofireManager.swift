//
//  MyAlamofireManager.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/26.
//

import Foundation
import Alamofire
import SwiftyJSON

final class MyAlamofireManager {
    // 싱글턴 적용
    static let shared = MyAlamofireManager()
    
    //인터셉터 : api 호출 시 가로채서 중간에 공통 파라미터를 넣거나 토큰 인증을 하거나 등
    let intercepters = Interceptor(interceptors: [
    BaseInterceptor()
    ])
    
    // 쿠기 설정
    let monitors = [MyLogger()]
    
    //세션 설정
    var session : Session
    private init() {
        session = Session(interceptor: intercepters, eventMonitors: monitors)
    }
    func getPhotos(searchTerm userInput: String, completion: @escaping (Result<[Photo], MyError>) -> Void) {
                    print("MyAlamofireManager - getPhotos() called userInput: \(userInput)")
                    self
                        .session
                        .request(MySearchRouter.searchPhotos(term: userInput)).validate(statusCode: 200..<401 ).responseJSON(completionHandler: {
                            response in
                            
                            guard let resposeValue = response.value else {
                                return
                            }
                            
                            var photos = [Photo]()
                            let responseJosn = JSON(response.value!)
                            //response 속 key 값인 results 를 찾아서 json으로 가져오겠다.
                            let jsonArray = responseJosn["results"]
                            
                            print("jsonArray.count:\(jsonArray.count)")
                            
                            for(index, subJson): (String,JSON) in jsonArray {
                                print("index:\(index), subjoson:\(subJson)")
                                //데이터 파싱
//                                let thumbnail = subJson["urls"]["thumb"].string ?? ""
//                                let username = subJson["user"]["username"].string ?? ""
//                                let likesCount = subJson["likes"].intValue ?? 0
//                                let createdAt = subJson["created"].string ?? ""
                                
                                guard let thumbnail = subJson["urls"]["thumb"].string,
                                      let username = subJson["user"]["username"].string,
                                      let createdAt = subJson["created_at"].string else { return }
                                
                                let likesCount = subJson["likes"].intValue ?? 0
                                
                                let photoItem = Photo(thumbnail:  thumbnail, username: username, likesCount: likesCount, createdAt: createdAt)
                                
                                //배열에 넣고
                                photos.append(photoItem)
                            }
                            
                            if photos.count > 0 {
                                completion(.success(photos))
                            } else {
                                completion(.failure(.noContent))
                            }
                        })
                    }
}
