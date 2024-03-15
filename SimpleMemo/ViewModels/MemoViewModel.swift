//
//  MemoViewModel.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit

class MemoViewModel {
    
    let dataManager: CoreDataManager
    
    var memo: Memo?
    
    // 의존성 주입
    init(dataManager: CoreDataManager, memo: Memo? = nil) {
        self.dataManager = dataManager
        self.memo = memo
    }
    
    
}
