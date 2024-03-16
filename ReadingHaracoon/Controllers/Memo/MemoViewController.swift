//
//  MemoViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import UIKit

final class MemoViewController: BaseViewController {
    
    let mainView = MemoView()
    let viewModel = MemoViewModel()
    
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
        
        // 계속 뷰를 업데이트 해줘야하나..?
        //mainView.configureView()
        viewModel.inputViewWillApeearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension MemoViewController {
    
    private func configureView() {
        mainView.writeButton.addTarget(self, action: #selector(didWriteButtonTapped), for: .touchUpInside)
        mainView.collectionView.delegate = self
    }
    
    @objc func didWriteButtonTapped() {
        let vc = DetailMemoViewController()
        vc.viewModel.bookData = viewModel.bookData
        vc.viewModel.viewMode = .create
        transition(viewController: vc, style: .push)
    }
    
    private func bindViewModel() {
        
        viewModel.outputMemoList.bind { [weak self] memoList in
            guard let self else { return }
            self.mainView.memoList = memoList
            self.mainView.updateSnapShot()
        }
    }
}


// MARK: - CollectionView
extension MemoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailMemoViewController()
        let data = mainView.memoList[indexPath.item]
        vc.mainView.titleTextField.text = data.title
        vc.mainView.contentTextView.text = data.content
        vc.viewModel.viewMode = .read
        vc.viewModel.memo = data
        transition(viewController: vc, style: .push)
    }
}
