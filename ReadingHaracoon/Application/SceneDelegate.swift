//
//  SceneDelegate.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import Then

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let bookRepository = BookRepository()
    var window: UIWindow?
    var errorWindow: UIWindow?
    
    var networkMonitor: NetworkMonitor = NetworkMonitor()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let tabBar = TabBarController()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        networkMonitor.stopMonitoring()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        guard let runningTimerBookISBN = UserDefaultsManager.shared.getRunningTimerBookISBN() else { return }
        guard let book = bookRepository.fetchBookItem(runningTimerBookISBN) else { return }
        let message = "[\(book.title)] 타이머가 실행되고 있다쿤!"
        
        guard let rootViewController = window?.rootViewController else { return }
        self.passMessageViewController(viewController: rootViewController, message: message)
    }
    
    /// RootVC 로 부터 자식 VC 순회, RunningTimerBookMessageProtocol을 채택한 경우 메세지 전달
    func passMessageViewController(viewController: UIViewController, message: String) {
        if let runningTimerBookMessageVC = viewController as? RunningTimerBookMessageProtocol {
            runningTimerBookMessageVC.runningTimerBookMessageReceived(message: message)
        }
        
        viewController.children.forEach {
            passMessageViewController(viewController: $0, message: message)
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

