//
//  LookAroundLayoutStatus.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import Foundation

//이 데이터에 의해서 상단의 것도 바뀌도록 설계해야 한다.
//클라이언트 개발자는 항상 서버를 생각해야 한다.
enum LookAroundLayoutStatus {
    //주입하기
    case chart(lookAroundChartAttribute: LookAroundChartAttribute)
    case interestedGroup(interestedStatus: LookAroundInterestedStatus)
}
