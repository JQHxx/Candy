//
//  UGCVideoListCell.swift
//  QYNews
//
//  Created by Insect on 2018/12/7.
//  Copyright © 2018 Insect. All rights reserved.
//

import UIKit

class UGCVideoListCell: CollectionViewCell, NibReusable {

    @IBOutlet private weak var diggCountLabel: Label!
    @IBOutlet private weak var titleLabel: Label!
    @IBOutlet private weak var playCountLabel: Label!
    @IBOutlet private(set) weak var coverImage: ImageView!

    public var item: UGCVideoListModel? {

        didSet {

            guard let item = item else { return }
            coverImage
            .qy_setImage(item.video?.raw_data.video.origin_cover.url_list.first, options: [KfOptions.fadeTransition(imageTransitionTime)])
            titleLabel.text = item.video?.raw_data.title
            playCountLabel.text = "\(item.video?.raw_data.action.playCountString ?? "")次播放"
            diggCountLabel.text = "\(item.video?.raw_data.action.diggCountString ?? "")赞"
        }
    }
}
