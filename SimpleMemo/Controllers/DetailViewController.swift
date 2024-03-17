//
//  DetailViewController.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/16/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // 코어데이터 모델
    let memoManager = CoreDataManager.shared
    
    var memo: Memo?
    
    // MARK: - UI구현
    
    let contentsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        button.tintColor = .white
        button.backgroundColor = .systemPink
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        button.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside
        )
        
        return button
    }()
    
    lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteButtonTapped)
        )
        button.tintColor = .label
        
        return button
    }()
    
    // MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupTextView()
        setupUI()
        setupLayout()
    }
    
    private func setupNavi() {
        if memo == nil {
            title = "새로운 메모 추가하기"
        } else {
            title = "메모 수정하기"
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    private func setupTextView() {
        contentsTextView.delegate = self
    }
    
    private func setupUI() {
        if let memo = memo {
            contentsTextView.text = memo.contents
            contentsTextView.becomeFirstResponder()
        } else {
            contentsTextView.text = "텍스트를 여기에 입력하세요."
            contentsTextView.textColor = .lightGray
        }
    }
    
    private func setupLayout() {
        view.addSubview(contentsTextView)
        view.addSubview(saveButton)
        
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.height.equalTo(300.0)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(contentsTextView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(40.0)
        }
    }
    
    @objc func saveButtonTapped() {
        if let memo = memo {
            // 기존 데이터가 있을때 => 기존 데이터 업데이트
            memo.contents = contentsTextView.text
            memoManager.updateMemo(newMemo: memo) {
                print("업데이트 완료")
            }
        } else {
            // 기존 데이터가 없을때 => 새로운 데이터 생성
            let contents = contentsTextView.textColor == .lightGray ? "" : contentsTextView.text
            memoManager.saveMemo(contents: contents) {
                print("저장 완료")
            }
        }
        
        // 이전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(
            title: "메모 삭제하기",
            message: "정말 삭제하시겠습니까?",
            preferredStyle: .alert
        )
        
        let success = UIAlertAction(title: "확인", style: .default) { [weak self] action in
            if let memo = self?.memo {
                self?.memoManager.deleteMemo(memo: memo) {
                    print("삭제 완료")
                    // 전화면으로 돌아가기
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(success)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // 다른 화면 터치 시 키보드 내려가게 만들기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// 텍스트뷰 플레이스 홀더 직접 구현하기
extension DetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
