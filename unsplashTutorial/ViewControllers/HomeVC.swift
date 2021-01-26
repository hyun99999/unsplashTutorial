//
//  ViewController.swift
//  unsplashTutorial
//
//  Created by kimhyungyu on 2021/01/23.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC:  BaseVC, UISearchBarDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    var keyboardDismissTabGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    //MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("HomeVC - viewDidLoad() called")
        self.config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //화면 로드 시 키보드 포커싱 추가
         self.searchBar.becomeFirstResponder()
    }
    
    //세그로 다른 화면으로 넘어가기 전에 준비한다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVC - prepare() called / segue.identifier: \(segue.identifier)")
        switch segue.identifier {
        case SEGUE_ID.USER_LIST_VC:
            //다음 화면의 뷰 컨트롤러를 가져온다.
            let nextVC = segue.destination as! UserListVC
            guard let userInputValue = self.searchBar.text else { return }
            nextVC.vcTitle = userInputValue + " 👨🏻‍💻"
        case SEGUE_ID.PHOTO_COLLECTION_VC :
            let nextVC = segue.destination as! PhotoCollectionVC
            guard let userInputValue = self.searchBar.text else { return }
            nextVC.vcTitle = userInputValue + " 🏞"
        default:
            print("default")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear() called")
        //키보드 올라가는 이벤트를 받는 처리
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeVC - viewWillDisappear() called")
        //keyboard notification remove
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - fileprivate methods
    fileprivate func config(){
        //UI설정
        searchBtn.layer.cornerRadius = 10
        searchBar.searchBarStyle = .minimal
        //searchBar delegate 연결
        self.searchBar.delegate = self
        //UIGestureReconizerDelegate 연결
        self.keyboardDismissTabGesture.delegate = self
        //최상단 뷰에 접근. 누르면 키보드를 내리기 위해서
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    
    fileprivate func pushVC() {
        //미리 스토리보드에서 정해둔 세그로 화면이동
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
    
    @objc func keyboardWillShowHandle(notification: NSNotification) {
        print("HomeVC - keyboardSWillShowHandle() called")
        //버튼을 덮은 키보드 사이즈만큼 y축을 올리면 된다.
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboardSize.height: \(keyboardSize.height)")
            print("searchBtn.frame.origin.y: \(searchBtn.frame.origin.y)")
            
            if keyboardSize.height < searchBtn.frame.origin.y {
                print("키보드가 버튼을 덮었다.")
                let distance = keyboardSize.height - searchBtn.frame.origin.y
                self.view.frame.origin.y = distance
            }
        }
    }
    @objc func keyboardWillHideHandle(notification: UNUserNotificationCenter) {
        print("HomeVC - keyboardWillHideHandle() called")
        self.view.frame.origin.y = 0
    }
    
    
    //MARK: - @IBAction methods
    @IBAction func searchFilterValueChanged(_ sender: UISegmentedControl) {
//        print("HomeVC - searchFilterValueChanged() called \(sender.selectedSegmentIndex )")
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
        //키보드 포커싱을 준다. searchFilter 값이 변할경우 즉 sindicatior 가 변할 때 키보드가 올라온다.
        self.searchBar.becomeFirstResponder()
    }
    
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called \(searchFilterSegment.selectedSegmentIndex)")
//        let url = API.BASE_URL + "search/photos"
        
        guard let userInput = self.searchBar.text else { return }
        
        //딕셔너리
//        let queryParam = ["query" : userInput,"client_id" : API.CLIENT_ID]

        //        AF.request(url, method: .get, parameters: queryParam).responseJSON(completionHandler: {
//            response in debugPrint(response)
//        })
        var urlToCall: URLRequestConvertible?
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            urlToCall = MySearchRouter.searchPhotos(term: userInput)
        case 1:
            urlToCall = MySearchRouter.searchUsers(term: userInput)
        default:
            print("default")
        }
        if let urlConvertible = urlToCall {
            //위의 주석과 같이 AF 를 미리만들어둔 클래스로 호출.
            //우리가 설정한 baseinterceptor 가 적용됨.
            //validate() 를 통해서 key값의 예외처리 가능. -> 실패 시 myApiSearchLogger 의 retry 가 발생
            MyAlamofireManager
                .shared
                .session
                .request(urlConvertible).validate(statusCode: 200..<401 ).responseJSON(completionHandler: {
                    response in
    //                debugPrint(response)
                })
        }
        
        //화면 이동
        //pushVC()
    }
    
    //MARK: - UISearchBar Delegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("HomeVC - searchBarSearchButtonClicked() called")
        guard let userInputString = searchBar.text else { return }
        if userInputString.isEmpty {
            self.view.makeToast("🤨 검색 키워드를 입력해주세요.", duration: 1.0, position: .center)
        } else {
            //입력값이 있다면 화면이동
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HomeVC - searchBar textDidChange() searchText: \(searchText)")
        
        if searchText.isEmpty {
            self.searchBtn.isHidden = true
            //약간의 딜레이를 주어서 비동기 처리할 것. searchBar 의 전체삭제를 누르면 삭제되서 내려가야하는데 bar 를 누르는 것이라서 키보드가 내려가지 않는 문제.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                                            searchBar.resignFirstResponder()
            })
            //키보드 포커싱 해제
        } else {
            self.searchBtn.isHidden = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        print("shouldChangeTextIn: \(inputTextCount)")
        //위의 searchBar 함수보다 이 함수가 더 빠르기 때문에(shoudlChangedTextIn) 여기에 설정해야 13자가 화면상으로 입력되기 전에 설정 가능.
        if inputTextCount >= 12 {
            // toast with a specific duration and position
            self.view.makeToast("🧐 12자까지만 입력가능합니다.", duration: 1.0, position: .center)
        }
        //12자까지만 입력. 13자부터는 false 로 searchBar 에 입력이 되지 않는다.
        if inputTextCount <= 12 {
            return true
        } else {
            return false
        }
        //return inputTextCount <= 12 와 같다.
    }
    
    //MARK: - UIGestureReconizerDelegate methods
    //keyboard dismiss 를 위한 제스쳐 등록
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("HomeVC - gestureRecongnizer() called")
        
        //특정한 요소에 대해서 예외처리(searchBar, segmentIndicator)
        if touch.view?.isDescendant(of: searchFilterSegment) == true {
            return false
        } else if touch.view?.isDescendant(of: searchBar) == true {
            return false
        } else {
            view.endEditing(true)
            return true
        }
        
    }
}

