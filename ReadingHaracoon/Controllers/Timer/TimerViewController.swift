//
//  TimerViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/17/24.
//

import UIKit

final class TimerViewController: BaseViewController {
    
    let mainView = TimerView()
    let viewModel = TimerViewModel()
    
    weak var delegate: PassResultMessageDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
        
        viewModel.inputViewDidLoadTrigger.value = ()
    }
}


// MARK: - Custom Func
extension TimerViewController {
    
    private func configureView() {
        mainView.startStopButton.addTarget(self, action: #selector(didStartStopButtonTapped), for: .touchUpInside)
        mainView.resetButton.addTarget(self, action: #selector(didResetButtonTapped), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(didSaveButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(didCancelButtonTapped), for: .touchUpInside)
    }
    
    @objc func didStartStopButtonTapped() {
        viewModel.inputDidStartStopButtonTappedTrigger.value = ()
    }
    
    @objc func didResetButtonTapped() {
        viewModel.inputDidResetButtonTappedTrigger.value = ()
    }
    
    @objc func didSaveButtonTapped() {
        showCustomAlert(title: "타이머를 저장한다쿤!", message: "저장저장!", actionTitle: "저장") {
            self.viewModel.inputDidSaveButtonTappedTrigger.value = ()
        }
    }
    
    @objc func didCancelButtonTapped() {

        if (viewModel.startTime != nil) || (viewModel.stopTime != nil) {
            showCustomAlert(title: "타이머가 남아있다쿤!", message: "취소하면 타이머는 사라진다쿤!", actionTitle: "확인") {
                self.viewModel.inputDidResetButtonTappedTrigger.value = ()
                self.presentingViewController?.dismiss(animated: true)
            }
        } else {
            dismiss(animated: true)
        }
    }
}


// MARK: - BindViewModel
extension TimerViewController {
    
    private func bindViewModel() {
        
        viewModel.outputStartStopButtonState.bindOnChanged { [weak self] state in
            guard let self else { return }
            if state {
                self.mainView.startStopButton.configuration?.title = "STOP"
                self.mainView.startStopButton.configuration?.baseForegroundColor = .systemRed
            } else {
                self.mainView.startStopButton.configuration?.title = "START"
                self.mainView.startStopButton.configuration?.baseForegroundColor = .point
            }
        }
        
        viewModel.outputTimeLabelText.bindOnChanged { [weak self] text in
            guard let self else { return }
            self.mainView.timeLabel.text = text
        }

        viewModel.outputDataBaseReslutMessage.bindOnChanged { [weak self] message in
            guard let self else { return }
            switch message {
            case .success(let message):
                showToast(message: message)
                self.delegate?.resultMessageReceived(message: message)
                self.presentingViewController?.dismiss(animated: true)
            case .fail(let message):
                self.showToast(message: message)
            }
        }
    }
}
