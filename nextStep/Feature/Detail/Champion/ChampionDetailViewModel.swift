//
//  ChampionDetailViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import Foundation
import RxSwift
import RxCocoa

final class ChampionDetailViewModel: BaseViewModel {
    let championID: String
    let contentOffset = BehaviorRelay<CGPoint>(value: CGPoint(x: 0, y: 0))
    let layoutStatusList = BehaviorRelay<[ChampionDetailLayoutStatus]>(value: [])
    let championDetailData = BehaviorRelay<ChampionDetailPageAttribute?>(value: nil)

    let skinListSwipeGesture = PublishRelay<UISwipeGestureRecognizer>()
    let skillButtonTap = PublishRelay<ChampionDetailSkillAttribute>()

    init(championID: String) {
        self.championID = championID
        super.init()
        lifeCycleStatus
            .filter { $0 == .viewDidLoad }
            .take(1)
            .bind(onNext: { [weak self] _ in
                self?.bind()
            })
            .disposed(by: disposeBag)
    }

    func getContentsOffsetY() -> Observable<CGFloat> {
        contentOffset
            .map { $0.y }
            .asObservable()
    }

    func getChampionDetailPageData() -> Observable<ChampionDetailPageAttribute?> {
        championDetailData
            .asObservable()
    }

    func getChampionTitleName() -> Observable<String?> {
        championDetailData
            .map {
                $0?.championName
            }
    }

    func getLayoutStatusList() -> Observable<[ChampionDetailLayoutStatus]> {
        layoutStatusList
            .asObservable()
    }

    func getLayout(indexPath: IndexPath) -> ChampionDetailLayoutStatus {
        layoutStatusList.value[indexPath.row]
    }

    func getSkinImageURLList() -> Observable<[ChampionDetailSkinAttribute]> {
        championDetailData
            .map {
                $0?.skinList ?? []
            }
    }

    func getSkinImageURLListPrimitvie() -> [ChampionDetailSkinAttribute] {
        let result = championDetailData.value
            .map {
                $0.skinList
            }
        return result ?? []
    }

    func getChampionDescription() -> Observable<ChampionDetailDescriptionAttribute> {
        championDetailData
            .filter { $0 != nil }
            .map {
                ChampionDetailDescriptionAttribute(
                    tagList: $0?.championTagList ?? ["Common"],
                    championName: $0?.championName ?? "",
                    championTItle: $0?.championTitle ?? "",
                    championDescription: $0?.championDescription ?? ""
                )
            }
    }

    func getChampionDescriptionPrimitive() -> ChampionDetailDescriptionAttribute? {
        championDetailData.value
            .map {
                ChampionDetailDescriptionAttribute(
                    tagList: $0.championTagList,
                    championName: $0.championName,
                    championTItle: $0.championTitle,
                    championDescription: $0.championDescription
                )
            }
    }

    func getChampionSkill(skillStatus: LOLSkillStatus) -> Observable<ChampionDetailSkillAttribute> {
        championDetailData
            .map { $0?.skillList ?? [] }
            .map { skillList in
                skillList.filter { skill in
                    skillStatus == skill.skillStatus
                }
            }
            .filter { !$0.isEmpty }
            .map { $0[0] }
    }

    func getChampionSkillPrimitive(skillStatus: LOLSkillStatus) -> ChampionDetailSkillAttribute? {
        let mapList = championDetailData.value
            .map { $0.skillList }
            .map { skillList in
                skillList.filter { skill in
                    skillStatus == skill.skillStatus
                }
            }
        return mapList?[safe: 0]
    }

    func getSkillButtonTapWithSkillAttribute() -> Observable<ChampionDetailSkillAttribute> {
        skillButtonTap
            .asObservable()
    }

    private func bind(_ repository: ChampionDetailRepository = ChampionDetailRepository()) {
        repository.getLayoutStatusList()
            .take(1)
            .bind(to: layoutStatusList)
            .disposed(by: disposeBag)

        repository.getChampionDetailPageAttribute(championID: championID)
            .take(1)
            .bind(to: championDetailData)
            .disposed(by: disposeBag)
    }
}
