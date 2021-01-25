//
//  BaseVC.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/25.
//

import UIKit

class BaseVC: UIViewController {
    var vcTitle : String = "" {
        didSet {
            print("UserListVC - vctitle didSet() called / vcTitle : \(vcTitle)")
            self.title = vcTitle
        }
    }
}
