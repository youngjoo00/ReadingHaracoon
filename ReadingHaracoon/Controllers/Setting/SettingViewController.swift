//
//  SettingViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit

extension SettingViewController {
    
    enum Setting: Int, CaseIterable {
        case support
        case other
        case version
        
        var sectionTitle: String {
            switch self {
            case .support:
                return "지원"
            case .other:
                return "기타"
            case .version:
                return "버전"
            }
        }
        
        var sectionContent: [String] {
            switch self {
            case .support:
                return ["문의하기"]
            case .other:
                return ["개인정보 이용약관"]
            case .version:
                return ["현재 사용중인 앱 버전 : 1.0.0"]
            }
        }
    }
}

final class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
}

extension SettingViewController {
    
    private func configureView() {
        configureLogo()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}


// MARK: - TableView
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Setting.allCases[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases[section].sectionContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        let title = Setting.allCases[indexPath.section].sectionContent[indexPath.row]
        cell.updateView(title)
        return cell
    }
    
    
}
