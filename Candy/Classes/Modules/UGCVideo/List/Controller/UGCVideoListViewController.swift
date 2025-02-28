//
//  UGCVideoListViewController.swift
//  QYNews
//
//  Created by Insect on 2018/12/7.
//  Copyright © 2018 Insect. All rights reserved.
//

import UIKit
import Hero
import JXCategoryView

class UGCVideoListViewController: CollectionViewController<UGCVideoListViewModel> {

    /// 视频类型
    private var category: String = ""

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - init
    init(category: String) {
        self.category = category
        super.init(collectionViewLayout: UGCVideoListFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func makeUI() {
        super.makeUI()

        collectionView.register(R.nib.ugcVideoListCell)
        collectionView.refreshHeader = RefreshHeader()
        collectionView.refreshFooter = RefreshFooter()
        beginHeaderRefresh()
    }

    override func bindViewModel() {
        super.bindViewModel()

        viewModel
        .input
        .category
        .onNext(category)

        collectionView.rx.itemSelected
        .asDriver()
        .drive(viewModel.input.selection)
        .disposed(by: rx.disposeBag)

        viewModel.output
        .items
        .drive(collectionView.rx.items(cellIdentifier: R.reuseIdentifier.ugcVideoListCell.identifier,
                                       cellType: UGCVideoListCell.self)) { collectionView, item, cell in
            cell.item = item
        }
        .disposed(by: rx.disposeBag)

        // 数据源 nil 时点击
        emptyDataSetViewTap
        .bind(to: rx.post(name: Notification.UGCVideoNoConnectClick))
        .disposed(by: rx.disposeBag)
    }
}
