# 📚 독서하라쿤
독서 생활을 더욱 풍부하게 만들어줄 귀여운 라쿤과 함께하는 도서 기록 및 관리 앱 “독서하라쿤” 입니다.

### 스크린샷
<img src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/b6f61e2d-e073-4d27-9665-23db888bf4c4" width="200" height="400">
<img src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/8f88184e-bf00-4309-8620-a65b3e90ee0a" width="200" height="400">
<img src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/df04b568-78a2-4927-9903-56c21333fdd2" width="200" height="400">
<img src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/351a12eb-d771-46b2-adc3-3056823ea974" width="200" height="400">
<img src="https://github.com/youngjoo00/ReadingHaracoon/assets/90439413/d214945f-f29f-45f5-9728-8b18dbef1a48" width="200" height="400">

### 앱 기능

- 도서 저장: 검색 화면에서 다양한 추천 도서를 확인하거나, 직접 검색하여 읽고 싶은 책을 손쉽게 저장하고 관리할 수 있습니다.
- 메모 기록: 책을 읽는 도중 떠오른 생각이나 중요한 내용을 메모하여 독서의 깊이를 더할 수 있습니다.
- 독서 타이머: 독서 시간을 정확하게 측정할 수 있는 타이머 기능을 제공합니다.
- 통계: 독서한 책과 시간을 캘린더와 차트를 통해 시각적으로 한눈에 파악할 수 있습니다.

### 개발환경

- 최소 버전: iOS 16.0
- 지원 모드: Light 모드 지원 (Dark 모드 지원 예정)
- IDE: Xcode 15.3
- Database: Realm

### **Dependency Manager**

- Swift-Package-Manager
- CocoaPods

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

## 고려사항

### 네트워크 감지

- 라이브러리인 Reachability 대신, 애플에서 제공하는 프레임 워크인 NWPathMonitor 를 사용했습니다.
```swift
// SceneDelegate.swift

var errorWindow: UIWindow?
var networkMonitor: NetworkMonitor = NetworkMonitor()

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        networkMonitor.startMonitoring() { [weak self] connectionStatus in
            switch connectionStatus {
            case .satisfied:
                self?.removeNetworkErrorWindow()
                print("dismiss networkError View if is present")
            case .unsatisfied:
                self?.loadNetworkErrorWindow(on: scene)
                print("No Internet!! show network Error View")
            default:
                break
            }
        }
    }

private func loadNetworkErrorWindow(on scene: UIScene) {
    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = .statusBar
        window.makeKeyAndVisible()

        let noNetworkView = NoNetworkView(frame: window.frame)
        window.addSubview(noNetworkView)
        self.errorWindow = window
    }
}

private func removeNetworkErrorWindow() {
    errorWindow?.resignKey()
    errorWindow?.isHidden = true
    errorWindow = nil
}
```

### Custom Modal · Alert

- CustomPresentationController: UIPresentationController
frameOfPresentedViewInContainerView 함수에서 containerView, PresentedView 의 사이즈와 위치를 열거형 case 로 분기처리하여 사용했습니다.

- CustomTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate
생성한 CustomPresentationController 클래스에서 customModalPresentationStyle 을 지정해둔 열거형 스타일로 설정했습니다.
```swift
// BaseVC 에서 사용하려 했으나, Tabman 은 커스텀 VC 를 사용할 수 없으므로, VC 를 확장하여 사용
extension UIViewController {
    
    func showCustomAlert(style: CustomModalPresentationStyle = .alert,
                         title: String,
                         message: String?,
                         actionTitle: String,
                         completion: @escaping () -> Void) {
        let alertViewContrller = CustomAlertViewController(title: title, message: message, actionTitle: actionTitle, action: completion)
        let transitionDelegate = CustomTransitioningDelegate(style)
        alertViewContrller.modalPresentationStyle = .custom
        alertViewContrller.transitioningDelegate = transitionDelegate

        self.present(alertViewContrller, animated: true)
    }
    
    func showCustomModal(style: CustomModalPresentationStyle, viewController: UIViewController) {
        let modalViewController = viewController
        let transitionDelegate = CustomTransitioningDelegate(style)
        modalViewController.modalPresentationStyle = .custom
        modalViewController.transitioningDelegate = transitionDelegate
        
        self.present(modalViewController, animated: true)
    }
}
```

### Timer

- UserDefalutsManager, TimeManager 등 Singleton pattern 을 통해 객체에 하나의 인스턴스 사용
```swift
inputViewDidLoadTrigger.bindOnChanged { [weak self] _ in
    guard let self = self else { return }
    
    startTime = UserDefaultsManager.shared.getStartTime()
    stopTime = UserDefaultsManager.shared.getStopTime()
    timerCheck = UserDefaultsManager.shared.getTimerCheck()
    
    if timerCheck {
        startTimer()
    } else {
        stopTimer()
        if let start = startTime, let stop = stopTime {
            let time = calcRestartTime(start: start, stop: stop)
            let diff = Date().timeIntervalSince(time)
            setTimeLabel(Int(diff))
        }
    }
}

inputDidStartStopButtonTappedTrigger.bindOnChanged { [weak self] _ in
    guard let self = self else { return }
    
    if timerCheck {
        setStopTime(date: Date())
        stopTimer()
    } else {
        if let stop = stopTime {
            let restartTime = calcRestartTime(start: startTime ?? Date(), stop: stop)
            setStopTime(date: nil)
            setStartTime(date: restartTime)
        } else {
            setStartTime(date: Date())
        }
        startTimer()
    }
}
```

### POP

- swift 의 강력한 패러다임인 POP 를 학습하여 Protocol + Extension 활용
```swift
// Logo.swift
protocol Logo {
    func configureLogo()
}

extension UIViewController: Logo {
    func configureLogo() {
        let logoImage = UIImage(resource: .logo)
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFill
        
        let logoTypeImage = UIImage(resource: .logotype)
        let logoTypeImageView = UIImageView(image: logoTypeImage)
        logoTypeImageView.contentMode = .scaleAspectFill
        
        logoImageView.frame = CGRect(x: 0, y: 0, width: 33, height: 40)
        logoTypeImageView.frame = CGRect(x: 20, y: 0, width: 150, height: 40)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        container.addSubview(logoImageView)
        container.addSubview(logoTypeImageView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: container)
    }
}

// RunningTimerBookMessageProtocol.swift
protocol RunningTimerBookMessageProtocol {
    func runningTimerBookMessageReceived(message: String)
}

extension BaseViewController: RunningTimerBookMessageProtocol {
    func runningTimerBookMessageReceived(message: String) {
        showToast(message: message)
    }
}
```

### Alamofire

- Router Pattern 을 통해 네트워크 통신을 위한 Endpoint 를 생성하는 로직 추상화
- Singleton pattern, Generic, Result Type 을 통해 네트워크 통신
- Request 실패했을 때, switch 구문으로 분기처리하여 다양한 상황에 대응

### MVVM + Custom Observer Pattern
- Model, View, ViewModel 역할 분리
- Observable 클래스를 생성하여 비동기성 처리 및 데이터 스트림 처리

## 트러블 슈팅

## 회고

