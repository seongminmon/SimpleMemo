//
//  SceneDelegate.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let dataManager = CoreDataManager.shared
        let memoListVM = MemoListViewModel(dataManager: dataManager, title: "메모")
        let memoListVC = MemoListViewController(viewModel: memoListVM)
        let naviVC = UINavigationController(rootViewController: memoListVC)
        
        window?.rootViewController = naviVC
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
