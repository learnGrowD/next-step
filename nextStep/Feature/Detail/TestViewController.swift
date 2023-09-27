//
//  TestViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/27.
//

import UIKit

class TestViewController: UIViewController {

    let aaaLabel = UILabel()
    let bbbLabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(aaaLabel, bbbLabel)
        let text = "ㄹㄷ쟞ㄹ댜ㅐㅈ더햐ㅐㅓㅈ댜ㅐㅈㄷ허ㅐㅑㅈㄷ허ㅐㅑㅎㄷ저ㅐㅑㅎㄷ저ㅐㄷㅈ햐ㅓㅐ댲허잳햐ㅓㅎㄷ쟈ㅐㅓㅎ대쟈ㅓㅎㄷ재ㅑㅓㄷㅎ쟈ㅐ허댜ㅐㅓㅈ대ㅑ헞대햐더ㅐㅑ저ㅐ댲헞ㄷ햐ㅐㅓㅈㅎ대ㅑㅓㅈㄷ해ㅑㅈ더ㅐ햐젖햐대ㅓㅈ댜ㅐ헏쟈ㅐㅎㅈ"
        aaaLabel.numberOfLines = 0
        bbbLabel.numberOfLines = 0
        aaaLabel.text = text
        bbbLabel.text = text

        aaaLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        bbbLabel.snp.makeConstraints {
            $0.top.equalTo(aaaLabel.snp.bottom).offset(32)
            $0.width.equalTo(144)
            $0.leading.equalToSuperview()
        }

        // UILabel 설정
        let label = UILabel()
        label.numberOfLines = 0 // 여러 줄에 걸쳐 표시 가능하도록 설정
        label.text = text

        // 너비에 따른 높이 계산
        let labelWidth1: CGFloat = UIScreen.main.bounds.width
        let labelWidth2: CGFloat = 144

        let labelSize1 = label.sizeThatFits(CGSize(width: labelWidth1, height: CGFloat.greatestFiniteMagnitude))
        let labelSize2 = label.sizeThatFits(CGSize(width: labelWidth2, height: CGFloat.greatestFiniteMagnitude))

        print("너비 100일 때 높이: \(labelSize1.height)")
        print("너비 200일 때 높이: \(labelSize2.height)")
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("aaa: \(aaaLabel.frame.height)")
        print("bbb: \(bbbLabel.frame.height)")
    }



}
