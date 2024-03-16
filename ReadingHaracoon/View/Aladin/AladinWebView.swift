//
//  AladinWebView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import UIKit
import Then
import WebKit

final class AladinWebView: BaseView {
    
    let navigationTitle = UILabel().then {
        $0.text = "Aladin WebView"
    }
    
    let webView = WKWebView()
    
    override func configureHierarchy() {
        [
            webView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
