# unsplashTutorial
unsplash 오픈 라이브러리를 활용한 image free download 튜토리얼
  > - Unsplash: https://unsplash.com
  > - Alamofire: https://www.google.com/search?client=safari&rls=en&q=alamofire&ie=UTF-8&oe=UTF-8
  > - Swifty-JSON: https://github.com/SwiftyJSON/SwiftyJSON

- navigation controller 를 이용.
- segue 를 이용한 화면 전환.
- dispatch  를 이용해서 searchBar 예외처리.
- delegate 를 채택해서 
  - UISearchBarDelegate : searchBar 에 대한 접근
  - UIGestureRecognizerDelegate : dismiss 제스처를 등록
- ARC : weak self 를 통해 메모리 카운트를 증가시키지 않는 것도 해봄

### Postman
- postman 활용해서 api 정보 확인
<img src = "https://user-images.githubusercontent.com/69136340/105805139-bfcd0a00-5fe4-11eb-8b1a-5f7290fd273d.png" width="600">

### Unsplash
- Unsplash는 Unsplash 라이선스에 따라 스톡 사진을 공유하는 전용 웹 사이트입니다
- unsplash 앱 등록 후 key 발급받기
- unsplash api 사용
  - 사진: https://unsplash.com/documentation#search-photos
  - 사용자: https://unsplash.com/documentation#search-users

### toast-swift
- https://github.com/scalessec/Toast-Swift
- 오픈 라이브러리 toast-swift 를 이용해서 토스트 메시지 사용.

### Alamofire
- https://github.com/Alamofire/Alamofire

### Swifty-JSON
-  https://github.com/SwiftyJSON/SwiftyJSON

## 완성
- main
<img src = "https://user-images.githubusercontent.com/69136340/106101214-e7f17000-6180-11eb-9ecd-01f5f529c77c.png" width ="250">

- Cat 을 unsplash 에 검색해서 json 데이터로 서버에서 가져온다.
<img src = "https://user-images.githubusercontent.com/69136340/106133344-775e4980-61a8-11eb-88b5-1dbae314d253.png" width="900">

- 예외처리 : 키 값 등 url 오류 시 retry() 를 통해서 toast 메시지 출력.
<img src = "https://user-images.githubusercontent.com/69136340/106101167-d8722700-6180-11eb-9bae-b3421315d5a1.png" width ="400">

- 출처 : 
- UI :[개발하는정대리]https://www.youtube.com/watch?v=pBG66IYtKlk&list=PLgOlaPUIbynqRzpQBIdEDnjDdkVsjHqxK&index=24
- Alamofire :[개발하는정대리]https://www.youtube.com/watch?v=WR4_KenX0G8&list=PLgOlaPUIbynqRzpQBIdEDnjDdkVsjHqxK&index=25
- JSON 파싱 :[개발하는정대리]https://www.youtube.com/watch?v=ww2md779iRs&list=PLgOlaPUIbynqRzpQBIdEDnjDdkVsjHqxK&index=26


## 에러해결
- Unknown class 'ViewController' in Interface Builder file
  - xcode 의 버그라는 의견이 지배적이라고 한다.
  - 상황 : 해당 뷰컨트롤러로 이동하려고할 때 뷰 컨트롤러의 클래스를 참조하지 못하는 상황 발생
  - 원인 : storyboard 에 viewController 의 identity inspector 에서 custom class 세션의 module 이 none 으로 되있지는 않은지 확인해보자.
  - 해결 : none 을 unsplashTutorial 으로 바꿔주자 해결.
<img src = "https://user-images.githubusercontent.com/69136340/105674247-8c2da980-5f2a-11eb-9541-71683fc670eb.png" width="900">

- 참고 : https://points.tistory.com/10

