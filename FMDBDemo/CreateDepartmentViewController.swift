//
//  CreateDepartmentViewController.swift
//  FMDBDemo
//
//  Created by masonhsieh on 2019/4/7.
//  Copyright © 2019 Frank.Chen. All rights reserved.
//

import UIKit

class CreateDepartmentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var departmentChineseNameTextField: UITextField!
    @IBOutlet var departmentEnglishNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonAction(_ sender: UIButton) {
        guard let departmentChineseName = departmentChineseNameTextField.text,
            let departmentEnglishName = departmentEnglishNameTextField.text else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "資料不足", message: "部門中文與英文名稱都要輸入值！", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                return
        }
        
        do {
            let departmentDao = DepartmentDao()
            try departmentDao.createDepartment(withEnglishName: departmentEnglishName, andChineseName: departmentChineseName)
            
            // clear text in both chinese and english text fields to create another one
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "", message: "部門新增成功", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "結束新增", style: .cancel, handler: { (action) in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }))
                alertController.addAction(UIAlertAction(title: "新增另一個", style: .default, handler: { (action) in
                    DispatchQueue.main.async {
                        self.departmentChineseNameTextField.text = ""
                        self.departmentEnglishNameTextField.text = ""
                        self.departmentChineseNameTextField.becomeFirstResponder()
                    }
                }) )
                
                self.present(alertController, animated: true, completion: nil)
            }
        } catch {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "新增失敗", message: "無法新增部門資料！\n\(error)", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.departmentChineseNameTextField {
            textField.resignFirstResponder()
            self.departmentEnglishNameTextField.becomeFirstResponder()
        } else if textField == self.departmentEnglishNameTextField {
            self.departmentEnglishNameTextField.resignFirstResponder()
        }
        
        return true
    }
}
