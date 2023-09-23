//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func font(bundle: Foundation.Bundle) -> font {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.font.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var launchScreen: launchScreen { .init(source: .init(bundle: bundle, tableName: "LaunchScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func launchScreen(preferredLanguages: [String]) -> launchScreen {
      .init(source: .init(bundle: bundle, tableName: "LaunchScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      let source: RswiftResources.StringResource.Source
    }

    /// This `_R.string.localizable` struct is generated, and contains static references to 0 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `nestStepBlack`.
    var nestStepBlack: RswiftResources.ColorResource { .init(name: "nestStepBlack", path: [], bundle: bundle) }

    /// Color `nestStepBrand`.
    var nestStepBrand: RswiftResources.ColorResource { .init(name: "nestStepBrand", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 14 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `positionBottom`.
    var positionBottom: RswiftResources.ImageResource { .init(name: "positionBottom", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `positionJungle`.
    var positionJungle: RswiftResources.ImageResource { .init(name: "positionJungle", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `positionMiddle`.
    var positionMiddle: RswiftResources.ImageResource { .init(name: "positionMiddle", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `positionSupport`.
    var positionSupport: RswiftResources.ImageResource { .init(name: "positionSupport", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `positionTop`.
    var positionTop: RswiftResources.ImageResource { .init(name: "positionTop", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierBronze`.
    var tierBronze: RswiftResources.ImageResource { .init(name: "tierBronze", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierChallenger`.
    var tierChallenger: RswiftResources.ImageResource { .init(name: "tierChallenger", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierDiamond`.
    var tierDiamond: RswiftResources.ImageResource { .init(name: "tierDiamond", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierGold`.
    var tierGold: RswiftResources.ImageResource { .init(name: "tierGold", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierGrandmaster`.
    var tierGrandmaster: RswiftResources.ImageResource { .init(name: "tierGrandmaster", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierIron`.
    var tierIron: RswiftResources.ImageResource { .init(name: "tierIron", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierMaster`.
    var tierMaster: RswiftResources.ImageResource { .init(name: "tierMaster", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierPlatinum`.
    var tierPlatinum: RswiftResources.ImageResource { .init(name: "tierPlatinum", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tierSilver`.
    var tierSilver: RswiftResources.ImageResource { .init(name: "tierSilver", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
          }
        }
      }
    }
  }

  /// This `_R.font` struct is generated, and contains static references to 2 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `NotoSans-Regular`.
    var notoSansRegular: RswiftResources.FontResource { .init(name: "NotoSans-Regular", bundle: bundle, filename: "NotoSans-Regular.ttf") }

    /// Font `NotoSans-SemiBold`.
    var notoSansSemiBold: RswiftResources.FontResource { .init(name: "NotoSans-SemiBold", bundle: bundle, filename: "NotoSans-SemiBold.ttf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [notoSansRegular, notoSansSemiBold].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 3 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `NotoSans-Regular.ttf`.
    var notoSansRegularTtf: RswiftResources.FileResource { .init(name: "NotoSans-Regular", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `NotoSans-SemiBold.ttf`.
    var notoSansSemiBoldTtf: RswiftResources.FileResource { .init(name: "NotoSans-SemiBold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `defaultLoading.json`.
    var defaultLoadingJson: RswiftResources.FileResource { .init(name: "defaultLoading", pathExtension: "json", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }
  }
}