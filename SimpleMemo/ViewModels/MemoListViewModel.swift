//
//  MemoListViewModel.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit

class MemoListViewModel {
    
    let dataManager: CoreDataManager
    
    let title: String
    
    var memoList: [Memo] {
        return dataManager.getMemoList()
    }
    
    // 의존성 주입
    init(dataManager: CoreDataManager, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    func makeMemoVM(memo: Memo?) -> MemoViewModel {
        return MemoViewModel(dataManager: self.dataManager, memo: memo)
    }
    
    func goToDetailVC(currentVC: UIViewController, memo: Memo?) {
        let memoVM = makeMemoVM(memo: memo)
        let detailVC = DetailViewController(viewModel: memoVM)
        let naviVC = currentVC.navigationController
        naviVC?.pushViewController(detailVC, animated: true)
    }
}
