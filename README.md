# unsplashTutorial
unsplash 오픈 라이브러리를 활용한 image free download 튜토리얼

- navigation controller 를 이용.
- segue 를 이용한 화면 전환.
- 오픈 라이브러리 toast-swift 를 이용해서 토스트 메시지 사용.
- dispatch  를 이용해서 searchBar 예외처리.
- delegate 를 채택해서 
  - UISearchBarDelegate : searchBar 에 대한 접근
  - UIGestureRecognizerDelegate : dismiss 제스처를 등록

## 완성

## 에러해결
- Unknown class 'ViewController' in Interface Builder file
  - xcode 의 버그라는 의견이 지배적이라고 한다.
  - 상황 : 해당 뷰컨트롤러로 이동하려고할 때 뷰 컨트롤러의 클래스를 참조하지 못하는 상황 발생
  - 원인 : storyboard 에 viewController 의 identity inspector 에서 custom class 세션의 module 이 none 으로 되있지는 않은지 확인해보자.
  - 해결 : none 을 unsplashTutorial 으로 바꿔주자 해결.
<img src = "https://user-images.githubusercontent.com/69136340/105674247-8c2da980-5f2a-11eb-9541-71683fc670eb.png" width="900">

- 참고 : https://points.tistory.com/10
