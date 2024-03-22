//
//  MemoViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/16/24.
//

import UIKit

final class MemoViewController: BaseViewController {
    
    let mainView = MemoView()
    let viewModel = MemoViewModel()
    
    var memoList: [Memo] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillApeearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension MemoViewController {
    
    private func configureView() {
        mainView.writeButton.addTarget(self, action: #selector(didWriteButtonTapped), for: .touchUpInside)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    @objc func didWriteButtonTapped() {
        let vc = DetailMemoViewController()
        vc.viewModel.bookData = viewModel.bookData
        vc.viewModel.viewMode = .create
        vc.delegate = self
        transition(viewController: vc, style: .push)
    }
    
    private func bindViewModel() {
        
        viewModel.outputMemoList.bind { [weak self] memoList in
            guard let self else { return }
            if memoList.isEmpty {
                mainView.noMemoLabel.isHidden = false
                self.mainView.tableView.isHidden = true
            } else {
                mainView.noMemoLabel.isHidden = true
                mainView.tableView.isHidden = false
                self.memoList = memoList
                self.mainView.tableView.reloadData()
            }
        }
    }
}


// MARK: - TableView
extension MemoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
        
        // 동적 높이 할당을 사용하기 위해 즉시 레이아웃 업데이트
        cell.layoutIfNeeded()
        let item = memoList[indexPath.row]
        cell.updateView(item)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMemoViewController()
        let data = memoList[indexPath.item]
        vc.mainView.titleTextField.text = data.title
        vc.mainView.contentTextView.text = data.content
        vc.viewModel.viewMode = .read
        vc.viewModel.memo = data
        vc.delegate = self
        transition(viewController: vc, style: .push)
    }
}



extension MemoViewController: PassResultMessageDelegate {
    func resultMessageReceived(message: String) {
        self.memoList = []
        showToast(message: message)
    }
}
