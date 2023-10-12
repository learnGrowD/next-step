//
//  RiotAPIRequestContext.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import Alamofire

struct RiotAPIRequestContext: APIRequestContextProtocol {
    static var baseURL: String {
        AppConfigure.isProductRelease
        ? "https://ddragon.leagueoflegends.com"
        : "https://test-ddragon.leagueoflegends.com"
    }
    private static var version = "13.16.1"
    private static var local: String {
        let currentLocal = Locale.current.identifier
        if currentLocal.contains("ko") {
            return "ko_KR"
        }
        if currentLocal.contains("en") {
            return "en_US"
        }
        return "en_US"
    }

    private static let championFullImgPath   = RiotAPIRequestContext.baseURL + "/cdn/img/champion/splash"
    private static let championMiddleImgPath = RiotAPIRequestContext.baseURL + "/cdn/img/champion/loading"
    private static let championSmallImgPath  = RiotAPIRequestContext.baseURL + "/cdn/\(RiotAPIRequestContext.version)/img/champion"
    private static let passiveImagePath = RiotAPIRequestContext.baseURL + "/cdn/\(RiotAPIRequestContext.version)/img/passive"
    private static let spellImagePath = RiotAPIRequestContext.baseURL + "/cdn/\(RiotAPIRequestContext.version)/img/spell"
    
    var serverName: String { "riot-api server" }
    var resultCode: String? { nil }

    var requestURL: String

    var params: [String : Any] = [:]

    var multipartFormDatas: [MultipartFormData] = []

    var requestUIMode: APIRequestUIMode

    var resultUIMode: APIResultUIMode

    var headers: HTTPHeaders

    init(
        path: String,
        params: [String: Any],
        requestUIMode: APIRequestUIMode,
        resultUIMode: APIResultUIMode,
        headers: HTTPHeaders = ["Content-Type": "application/json"]
    ) {
        self.requestURL = "\(RiotAPIRequestContext.baseURL)/cdn/\(RiotAPIRequestContext.version)/data/\(RiotAPIRequestContext.local)\(path)"
        self.params = params
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }

    init(
        path: String,
        multipartFormDatas: [MultipartFormData],
        requestUIMode: APIRequestUIMode,
        resultUIMode: APIResultUIMode,
        headers: HTTPHeaders = ["Content-Type": "multipart/form-data"]
    ) {
        self.requestURL = "\(RiotAPIRequestContext.baseURL)/cdn/\(RiotAPIRequestContext.version)/data/\(RiotAPIRequestContext.local)\(path)"
        self.multipartFormDatas = multipartFormDatas
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }

    //MARK: - ImageURL id, key를 통해서 convert
    static func getChampionImageURL(
        championImageSizeStatus: ChampionImageSizeStatus,
        championID: String?,
        skinIndexNumber: Int? = 0
    ) -> String? {
        switch championImageSizeStatus {
        case .full:
            return "\(championFullImgPath)/\(championID ?? "")_\(skinIndexNumber ?? 0).jpg"
        case .middle:
            return "\(championMiddleImgPath)/\(championID ?? "")_\(skinIndexNumber ?? 0).jpg"
        case .small:
            return "\(championSmallImgPath)/\(championID ?? "").png"
        }
    }

    static func getPassiveImageURL(passiveImagePath : String?) -> String? {
        //passiveImagePath like -> Alistar_E.png
        "\(RiotAPIRequestContext.passiveImagePath)/\(passiveImagePath ?? "")"
    }

    static func getSpellImageURL(spellID : String?) -> String? {
        "\(spellImagePath)/\(spellID ?? "").png"
    }

    static func getChampionSkillVedioURLWithMp4(championKey: String?, skillStatus: LOLSkillStatus) -> String {
        let key = championKey?.convertNumberWithZeros() ?? ""
        return "https://d28xe8vt774jo5.cloudfront.net/champion-abilities/\(key)/ability_\(key)_\(skillStatus.rawValue)1.mp4"
    }

    
}
