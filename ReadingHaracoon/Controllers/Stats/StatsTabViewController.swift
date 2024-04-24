//
//  StatsViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import Tabman
import Pageboy

final class StatsTabViewController: TabmanViewController {
    
    let mainView = StatsTabView()
    var viewControllers: [UIViewController] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        configureView()
    }
}

extension StatsTabViewController {
    
    private func configureView() {
        configureLogo()
        let calendarVC = CalendarViewController()
        let chartVC = ChartViewController()
        
        viewControllers.append(contentsOf: [calendarVC, chartVC])
        
        dataSource = self
        addBar(mainView.bar, dataSource: self, at: .custom(view: mainView.tabSpaceView, layout: nil))
    }
}
extension StatsTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "캘린더")
        case 1:
            return TMBarItem(title: "차트")
        default:
            return TMBarItem(title: "Page \(index)")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        guard viewControllers.indices.contains(index) else { return nil }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
}
