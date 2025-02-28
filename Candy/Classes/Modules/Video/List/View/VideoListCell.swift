//
//  VideoListCell.swift
//  QYNews
//
//  Created by Insect on 2018/12/5.
//  Copyright © 2018 Insect. All rights reserved.
//

import UIKit

class VideoListCell: TableViewCell {

    @IBOutlet private weak var largeImage: ImageView!
    @IBOutlet private weak var commentBtn: Button!
    @IBOutlet private weak var avatarBtn: Button!
    @IBOutlet private weak var nameLabel: Label!
    @IBOutlet private weak var titleLabel: Label!
    @IBOutlet private weak var playCountLabel: Label!
    @IBOutlet private weak var timeLabel: Label!
    @IBOutlet private(set) weak var videoBtn: Button!

    @IBAction private func avatarBtnDidClick(_ sender: UIButton) {

        return
        let vc = UserPorfileViewController(userID: item?.user_info.user_id ?? "")
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }

    public var item: NewsModel? {

        didSet {

            guard let item = item else { return }
            titleLabel.text = item.title

            let imageSize = CGSize(width: 40 * UIScreen.main.scale, height: 40 * UIScreen.main.scale)
            avatarBtn.qy_setImage(item.user_info.avatar_url,
                                  placeholder: R.image.avatar(),
                                  options: [KfOptions.corner(imageSize.width * 2, targetSize: imageSize), KfOptions.fadeTransition(Configs.Time.imageTransition)])
            nameLabel.text = item.user_info.name
            commentBtn.setTitle(" \(item.commentCountString)", for: .normal)
            timeLabel.text = item.videoDurationString
            playCountLabel.text = "\(item.video_detail_info.videoWatchCountString)次播放"
            largeImage
            .qy_setImage(item.video_detail_info.detail_video_large_image.url,
                         placeholder: R.image.placeholder(),
                         options: [KfOptions.fadeTransition(Configs.Time.imageTransition)])
        }
    }
}
