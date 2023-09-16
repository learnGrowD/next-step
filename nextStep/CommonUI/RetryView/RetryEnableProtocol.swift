//
//  RetryEnableProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit

//RetryView를 사용하고 싶은 ViewController or View에서 반드시 RetryEnabledProtocol를
//상속하여 layout 배치의 container가 되는 containerView 를 넘겨주는것과 동시에
//retry를 했을때 process 정의
protocol RetryEnabledProtocol {
    var retryContainerView: UIView { get }
    func processRetry()
}
