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
- 타이머가 진행 중인 경우
    
    SceneDelegate 의 sceneDidBecomeActive 메서드를 통해 Active 상태일 때, 유저 현재 화면에 Toast
    

**Singleton pattern**

- 하나의 인스턴스 사용으로 인한 메모리 사용 최소화

**Delegate Pattern, POP (Protocol-Oriented Programming)**

- Protocol + Extension 활용하여 공통 기능 모듈화

**MVVM + Custom Observer Pattern**

- Model, View, ViewModel 역할 분리
- Observable 클래스를 생성하여 비동기성 처리 및 데이터 스트림 처리

**Base View, Custom View**

- UIKit 의 View Class 를 상속받은 Base Class 를 생성하여 사용성 용이

**Search**

- offset 기반 무한스크롤 구현
