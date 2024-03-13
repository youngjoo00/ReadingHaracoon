//
//  CustomPresentationController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/13/24.
//

import UIKit

enum CustomModalPresentationStyle {
    case bottom
    case center
}

final class CustomPresentationController: UIPresentationController {
    
    private var backgroundView: UIView?
    var customModalPresentationStyle: CustomModalPresentationStyle?
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView, let presentStyle = customModalPresentationStyle else { return .zero }
        
        switch presentStyle {
        case .bottom:
            // containerView의 크기를 기준으로 ModalView의 크기 계산
            let size = CGSize(width: containerView.bounds.width,
                              height: containerView.bounds.height * 0.5)
            
            // containerView의 크기를 기준으로 ModalView의 위치 계산
            let origin = CGPoint(x: .zero, y: containerView.bounds.height * 0.5)
            
            return CGRect(origin: origin, size: size)
        case .center:
            let size = CGSize(width: containerView.bounds.width * 0.8,
                              height: containerView.bounds.height * 0.4)
            
            let origin = CGPoint(x: containerView.bounds.width * 0.1, y: (containerView.bounds.height - size.height) / 2)
            
            return CGRect(origin: origin, size: size)
        }
    }
    
    // 화면이 시작될 때
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView, let presentedView = presentedView else { return }
        
        // 모달 뷰 모서리 세팅
        presentedView.layer.cornerRadius = 16
        presentedView.layer.borderWidth = 1
        presentedView.layer.borderColor = UIColor.point.cgColor
        containerView.addSubview(presentedView)
        
        // 백그라운드 뷰 생성
        let backgroundView = UIView(frame: containerView.bounds)
        self.backgroundView = backgroundView
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.insertSubview(backgroundView, at: 0)
        
        // 바깥 영역 터치 시 모달 닫기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissController() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    // 화면이 사라질 때
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
    }
}
