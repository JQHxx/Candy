//
//  TabBarController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        seUpTabBarAttr()

        guard let jsonPath = R.file.mainVCSettingsJson()?.path else {
            return
        }

        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            return
        }

        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }

        guard let dictArray = anyObject as? [[String: AnyObject]] else {
            return
        }

        for dict in dictArray {

            guard let vcName = dict["vcName"] as? String else { continue }
            guard let normalImg = dict["normalImg"] as? String else { continue }
            guard let selImg = dict["selImg"] as? String else { continue }
            guard let title = dict["title"] as? String else { continue }

            addChildVc(childVcName: vcName, title: title, normalImg: normalImg, selImg: selImg)
        }
    }

    deinit {
        print("deinit: \(self)")
    }
}

// MARK: - 设置 TabBar 属性
extension TabBarController {

    private func seUpTabBarAttr() {

        UITabBarItem.appearance()
        .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.tabBarNormal], for: .normal)
        UITabBarItem.appearance()
        .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.main], for: .selected)

        tabBar.hero.modifiers = [.useGlobalCoordinateSpace,
                                 .useNoSnapshot, .zPosition(10),
                                 .translate(x: 0, y: 100, z: 0)]
    }
}

// MARK: - 设置子控制器
extension TabBarController {

    private func addChildVc(childVcName: String, title: String, normalImg: String, selImg: String) {

        let childVc = getVcFromString(childVcName)

        childVc.tabBarItem.image = UIImage(named: normalImg)
        childVc.tabBarItem.selectedImage = UIImage(named: selImg)
        childVc.tabBarItem.title = title

        let childNav = NavigationController(rootViewController: childVc)

        addChild(childNav)
    }

    private func getVcFromString(_ vcName: String) -> UIViewController {

        guard
            let childVc = vcName.classObject(UIViewController.self)
        else {
            return UIViewController()
        }

        return childVc
    }
}
