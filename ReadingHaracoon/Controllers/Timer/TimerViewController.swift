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
    }
    
    @objc func didStartStopButtonTapped() {
        viewModel.inputDidStartStopButtonTappedTrigger.value = ()
    }
    
    @objc func didResetButtonTapped() {
        viewModel.inputDidResetButtonTappedTrigger.value = ()
    }
    
    @objc func didSaveButtonTapped() {
        showCustomAlert(title: "타이머를 저장한다쿤!", message: "저장저장!", actionTitle: "저장") {
            print(self.viewModel.bookData)
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

    }
}
