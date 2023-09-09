//
//  BaseBottomModal.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

class BaseBottomModal<ViewModel: BaseViewModel>: UIViewController, BaseViewControllerProtocol {
    typealias ViewModel = ViewModel

    var viewModel: ViewModel
    let disposeBag = DisposeBag()

    private let backgroundView = UIView()
    private let containerView = UIView()

    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, viewModel: ViewModel) {
        self.viewModel = viewModel
        print("🍎 ViewModel init: \(viewModel.className)")
        super.init(nibName: nil, bundle: nil)
        self.mInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(hostViewController: UIViewController?) {
        hostViewController?.presentPanModal(self)
    }

    func layoutContainerView(topView: UIView) {
        containerView.snp.makeConstraints {
            $0.top.equalTo(topView).inset(-32)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(-56)
        }
    }

    func bindToView(_ viewModel: ViewModel) {
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    func bindToViewModel(_ viewModel: ViewModel) {}

    func attribute() {
        backgroundView.backgroundColor = .clear

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
    }

    /*
     ChildModal에서 layout 배치할때 아래에서 위로 쌓는다.
     이유는 동적으로 height 사이즈를 표현하고 싶기 때문이다.
     */
    func layout() {
        [
            backgroundView,
            containerView
        ].forEach {
            view.addSubview($0)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mViewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mViewDidAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.mViewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mViewDidLayoutSubviews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mViewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mViewDidDisappear(animated)
    }
    deinit {
        self.mDeinit()
    }
}
extension BaseBottomModal: PanModalPresentable {
    var showDragIndicator: Bool {
        return false
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    var anchorModalToLongForm: Bool {
        return false
    }
}
