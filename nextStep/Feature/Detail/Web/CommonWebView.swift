//
//  CommonWebView.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import UIKit
import WebKit

final class CommonWebView: WKWebView {
    func load(with url: URL?) {
        guard let url = url else { return }
        let urlReq = URLRequest(url: url)
        self.load(urlReq)
    }

}
