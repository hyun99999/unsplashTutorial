//
//  ViewController.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/23.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("HomeVC - viewDidLoad() called")
        
        searchBtn.layer.cornerRadius = 10
        searchBar.searchBarStyle = .minimal
        
    }
//MARK: - @IBAction methods
    @IBAction func searchFilterValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - searchFilterValueChanged() called \(sender.selectedSegmentIndex )")
        var searchBarTitle = ""
        switch sender.selectedSegmentIndex {
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        self.searchBar.placeholder = searchBarTitle + " 입력"
        //키보드 포커싱을 준다.(키보드가 가리면 알아서 화면 포커싱이동)
        self.searchBar.becomeFirstResponder()
        //self.searchBar.resignFirstResponder() 포커싱을 해제
    }
    
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called \(searchFilterSegment.selectedSegmentIndex)")
        //미리 스토리보드에서 정해둔 세그로 화면전환
        var segueID : String = ""
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            print("사진 화면으로이동")
            segueID = "goToPhotoCollectionVC"
        case 1:
            print("사용자 화면으로 이동")
            segueID = "goToUserListVC"
        default:
            print("default")
            segueID = "goToPhotoCollectionVC"
        }
        //세그를 이용한 네비게이션 화면이동
        self.performSegue(withIdentifier: segueID, sender: self)
    }
}

