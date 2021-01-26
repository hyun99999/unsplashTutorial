//
//  BaseVC.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/25.
//

import UIKit
import Toast_Swift

class BaseVC: UIViewController {
    var vcTitle : String = "" {
        didSet {
            print("UserListVC - vctitle didSet() called / vcTitle : \(vcTitle)")
            self.title = vcTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //인증 실패 notification 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification:)), name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //notification 등록해제
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL),object: nil)
    }
    
    //MARK: - objc methods
    @objc func showErrorPopup(notification: NSNotification) {
        print("BaseVC - showErrorPopup() called")
        
        if let data = notification.userInfo?["statusCode"] {
            print("showErrorPopup() data: \(data)")
            //UIViewController.view must be used from main thread only
            //디스패치큐로 메인스레드에서 실행해주지 않으면 위와 같은 오류를 내뱉는다. view 와 관련된 메서드들은 메인쓰레드에서 실행이 되어야 한다고 한다.
            DispatchQueue.main.async {
                self.view.makeToast("☠️ \(data) 에러 입니다.", duration: 1.5, position: .center)
            }
        }
    }
}
