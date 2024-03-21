//
//  PersonalInformationPolicy.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/21/24.
//

import UIKit

final class PersonalInformationPolicyViewController: BaseViewController {
    
    let mainView = PersonalInformationPolicyView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
