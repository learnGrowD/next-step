//
//  CommonWebViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import Foundation
import RxSwift
import RxCocoa

final class CommonWebViewModel: BaseViewModel {
    let webContext: WebContext
    init(webContext: WebContext) {
        self.webContext = webContext
        super.init()
    }

    func getTitle() -> Observable<String> {
        Observable.just(webContext.title)
    }

    func load() -> Observable<URL?> {
        Observable.just(webContext.link)
            .map { URL(string: $0) }
    }
}
