# **📚 독서하라쿤**

### 독서 생활을 더욱 풍부하게 만들어줄 귀여운 라쿤과 함께하는 도서 기록 및 관리 앱 “독서하라쿤”

### 스크린샷

<img width="1500" alt="앱스토어 사진" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/22df2e93-253e-4a70-8c1d-bdd36a12a3cb">


### **앱 기능**

1. 도서 검색 / 저장
    - 검색 화면에서 다양한 추천 도서를 확인하거나, 직접 검색하여 읽고 싶은 책을 손쉽게 저장하고 관리할 수 있습니다.
2. 메모 기록
    - 책을 읽는 도중 떠오른 생각이나 중요한 내용을 메모하여 독서의 깊이를 더할 수 있습니다.
3. 독서 타이머
    - 독서 시간을 정확하게 측정할 수 있는 타이머 기능을 제공합니다.
4. 통계
    - 독서한 책과 시간을 캘린더와 차트를 통해 시각적으로 한눈에 파악할 수 있습니다.

### **개발환경**

- 출시 기간: 2024.03.07 - 03.21 (2주)
- 출시 이후 ~ 현재까지 업데이트 진행중 : v1.0.1
- 기획/디자인/개발 - 1인
- 최소 버전: iOS 16.0
- 지원 모드: Light 모드 지원
- IDE: Xcode 15.3
- Database: Realm

### **Dependency Manager**

- Swift-Package-Manager
- CocoaPods

## 기술 스택

### **FrameWork**

- UIKit
- NWPathMonitor
- WebKit

### **Library**

- Alamofire
- DGCharts
- FSCalendar
- FSPagerView
- Kingfisher
- SVProgressHUD
- Tabman
- Snapkit
- Then
- Toast

## **고려사항**

**Alamofire**

- Router Pattern 을 통해 네트워크 통신을 위한 Endpoint 를 생성하는 로직 추상화
- Singleton pattern, Generic, Result Type 을 통해 네트워크 통신
- Request 실패했을 때, switch 구문으로 분기처리하여 다양한 상황에 대응

**Realm**

- Repository Pattern 기반 CRUD 구현으로 인한 데이터 액세스로직 캡슐화, 유지보수성 향상
- To-Many Relationship 사용으로 효율적인 Query
- do - try - catch 구문을 사용하여 transaction 의 성공 실패 여부 처리

**NWPathMonitor**

- 라이브러리인 Reachability 대신, 애플에서 제공하는 프레임 워크인 NWPathMonitor 사용
- SceneDelegate 에서 Monitoring 을 진행하여 네트워크 감지

**Timer**

- UserDefaults 를 이용한 Background Timer 구현
- 타이머가 진행 중인 경우 SceneDelegate 의 sceneDidBecomeActive 메서드를 통해 Active 상태일 때 Toast
    

**Singleton pattern**

- 하나의 인스턴스를 통해 메모리 사용 최소화

**MVVM + Custom Observer Pattern**

- Model, View, ViewModel 역할 분리
- Observable 클래스를 생성하여 비동기성 처리 및 데이터 스트림 처리

**Base View, Custom View**

- UIKit 의 View Class 를 상속받은 Base Class 를 생성하여 사용성 용이

**Search**

- offset 기반 무한스크롤 구현

## 트러블슈팅

### BackgroundTimer 사용 시 사용자에게 Toast

SceneDelegate LifeCycle 중 앱이 사용자와의 상호작용을 받을 준비가 완전히 된 시점에 호출하기 위해 `sceneDidBecomeActive` + `NotificationCenter` 를 통해 화면에 들어온 ViewController 에 Toast 를 전달하는 방식으로 구현

<img width="1920" alt="image" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/d3ac2ffc-8df7-4a24-aa06-64a01c46ae77">

### UIPresentationController 추상화

`UIPresentationController` + `UIViewControllerTransitioningDelegate` 를 통해 Custom Modal 화면 구현

하지만, Presentaion View 가 늘어남에 따라 코드의 중복성과 비효율성이 느껴졌기에 추상화하고 유지보수하기 용이한 코드로 개선

- 중복되는 코드
<img width="1920" alt="image" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/68210701-4ef7-443a-91bf-ab83bed3f796">

- 개선 결과
<img width="1803" alt="image" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/49ccd16a-a085-4c4b-a5c2-f1affdc7a0b5">

<details>
  <summary>개선 과정</summary>

1. CustomPresentationController + Enum
   - 분기별로 사용할 PresentStyle 생성
   <img width="1556" alt="image" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/dc341a0b-c9b2-4769-aeea-95c65df42072">

2. init 구문을 활용한 PresentationStyle 할당
   <img width="1806" alt="image" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/f7546ad9-37c3-4662-b675-13787b6c70f3">

3. UIViewController + Extension
   - 모든 뷰컨트롤러에서 쉽게 사용할 수 있도록 ShowCustomAlert, ShowCustomModal 메서드 생성
   - PresentationStyle을 매개변수로 받아서 CustomTransitioningDelegate를 생성할 때 받아온 Style 값을 넣어줌
   <img width="1920" alt="image" src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/e466eeea-fde5-464d-adf5-4599be670c5e">

</details>

## **프로젝트 회고**

### **좋았던 점**

- 다양한 디자인 패턴을 사용해 코드를 추상화 및 모듈화했습니다.
- GitHub 예시 프로젝트를 참고하며 처음 사용하는 라이브러리에 대한 두려움을 극복했습니다.
- DB를 직접 설계하여 To-Many Relationship 관계로 필터링과 데이터 추적이 용이했습니다.
- 개발 기간에 맞춰 빠르게 최소 단위 기능을 구현했습니다.

### **아쉬웠던 점**

- Dynamic Dispatch, Static Dispatch와 관련된 접근 제어자 private 키워드 사용이 미흡했습니다.
- View와 ViewModel 간 Input/Output 역할이 명확히 구분되지 않아 가독성이 떨어졌습니다.

### **추후 목표**

- 컴파일 속도 향상 및 가독성을 위해 접근 제어를 철저히 사용하겠습니다.
- RxSwift와 MVVM Input/Output을 사용하여 역할 분리 및 가독성을 향상시키겠습니다.

좋은 코드도 중요하지만, 기간 내에 기능을 구현하는 것이 가장 우선순위가 높음을 느꼈습니다.

정해진 시간에 맞춰 개발 속도를 유지하면서도 가독성 좋은 코드를 작성할 수 있는 개발자로 성장하기 위해 노력하겠다고 다짐했습니다.
