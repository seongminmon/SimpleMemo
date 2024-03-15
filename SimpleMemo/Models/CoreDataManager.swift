//
//  CoreDataManager.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit
import CoreData

// MARK: - 코어데이터 관리하는 매니저
final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름 (코어데이터에 저장된 객체 이름)
    let modelName = "Memo"
    
    // MARK: - CRUD
    
    // [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getMemoList() -> [Memo] {
        var memoList: [Memo] = []
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            // 정렬순서를 정해서 요청서에 넘겨주기
            // 날짜 기준 내림차순 (최신순)
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedMemoList = try context.fetch(request) as? [Memo] {
                    memoList = fetchedMemoList
                }
            } catch {
                print("Read 실패")
            }
        }
        
        return memoList
    }
    
    // [Create] 코어데이터에 데이터 생성하기
    func saveMemo(contents: String?, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기
                if let memoData = NSManagedObject(entity: entity, insertInto: context) as? Memo {
                    // memoData에 실제 데이터 할당
                    memoData.contents = contents
                    memoData.date = Date()  // 날짜는 저장하는 순간의 날짜로 생성
                    
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    // [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 => 삭제)
    func deleteMemo(memo: Memo, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = memo.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch 메서드)
                if let fetchedMemoList = try context.fetch(request) as? [Memo] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기
                    if let targetMemo = fetchedMemoList.first {
                        context.delete(targetMemo)
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("Delete 실패")
                completion()
            }
        }
    }
    
    // [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 => 수정)
    func updateMemo(newMemo: Memo, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newMemo.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch 메서드)
                if let fetchedMemoList = try context.fetch(request) as? [Memo] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 바꾸기 (재할당)
                    if var targetMemo = fetchedMemoList.first {
                        targetMemo = newMemo
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print("Update 실패")
                completion()
            }
        }
    }
}
