//
//  DefaultAttributeManager.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit

struct DefaultAttributeManager {

    static func viewDefailtAttribute() {
        UIView.appearance().backgroundColor = R.color.nestStepBlack()
        UILabel.appearance().textColor = .white
    }

    static func navigationBarDefaultAttribute() {
        let appearance = UINavigationBar.appearance()
        /*
         UINavigationBar 하단에 불투명한 그림자 표시에 관한 속성
         */
        appearance.shadowImage = UIImage()
        
        /*
         뒤로가기 이미지에 대한 속성
         */
//        appearance.backIndicatorImage = UIImage(named: backImgName)
//        appearance.backIndicatorTransitionMaskImage = UIImage(named: backImgName)

        /*
         NavigationBar 투명도에 대한 속성
         */
        appearance.isTranslucent = false

        /*
         탭바의 배경화면을 설정하는 속성
         */
        appearance.barTintColor = R.color.nestStepBlack()

        /*
         NavigationBar 탭바의 아이템 색깔을 설정하는 속성
         */
        appearance.tintColor = .white

        guard let font = R.font.notoSansRegular(size: 16) else { return }
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
    }

    static func tabBarDefailtAttribute() {
        /*
         상단 그림자
         */
        let appearance = UITabBar.appearance()
        appearance.layer.masksToBounds = false
        appearance.layer.shadowOffset = CGSize(width: 0, height: 0)
        appearance.layer.shadowRadius = 1

        appearance.layer.shadowColor = UIColor.clear.cgColor
        appearance.layer.shadowOpacity = 0

        /*
         Tap Color
         */
        appearance.tintColor = R.color.nestStepBlack()
        appearance.unselectedItemTintColor = R.color.nestStepBrand()
    }
}
