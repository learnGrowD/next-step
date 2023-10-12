//
//  CommonWebViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import UIKit
import WebKit

final class CommonWebViewController: BaseViewController<CommonWebViewModel> {
    private let webView = CommonWebView()
    private var loadingView: CommonLoadingView?

    override func attribute() {
        super.attribute()
        webView.navigationDelegate = self
        view.backgroundColor = R.color.nestStepBlack()
    }

    override func layout() {
        super.layout()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: CommonWebViewModel) {
        super.bind(viewModel)
        viewModel.getTitle()
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        
        viewModel.load()
            .bind(onNext: { [weak self] url in
                self?.webView.load(with: url)
            })
            .disposed(by: disposeBag)
    }
}

extension CommonWebViewController: WKNavigationDelegate {
    /*
      web 페이지의 로딩이 시작될때 호출되는 함수
      */
     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         showLoadingView()
     }

     /*
      web에서의 로딩이 완료되었을때 호출되는 함수
      */
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         hideLoadingView()
     }
}

extension CommonWebViewController {
    private func showLoadingView() {
        loadingView = CommonLoadingView(milliseconds: 0)
        loadingView?.show()
    }

    private func hideLoadingView() {
        loadingView?.dismiss()
        loadingView = nil
    }
}
