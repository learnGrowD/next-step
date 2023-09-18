//
//  APIResultUIMode.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

enum APIResultUIMode {
    case validation
    case showWarning
    case showToast
    case showRetryView

    /*
     앱의 구조에 따라서 추가
     ex) translateLogin: token이 만료되었거나 기타 등 login page로 전환한다.
     */

}
