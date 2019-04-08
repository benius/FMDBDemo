//
//  ListDepartmentsTableViewController.swift
//  FMDBDemo
//
//  Created by masonhsieh on 2019/4/7.
//  Copyright © 2019 Frank.Chen. All rights reserved.
//

import UIKit

class ListDepartmentsTableViewController: UITableViewController {
    
    private var departments: [Department] = []
    private var departmentDao: DepartmentDao?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        prepareDepartments()
    }
    
    func prepareDepartments() {
        DispatchQueue.global().async {
            if self.departmentDao == nil {
                self.departmentDao = DepartmentDao()
            }
            
            do {
                self.departments = try self.departmentDao!.findAllDepartments()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                // Failed to connect db
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "資料取得失敗", message: "無法取得部門資料，請稍後再試!\n\(error)", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return departments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath)

        // Configure the cell
        configure(withCell: cell, tableView: tableView, cellForRowAt: indexPath)

        return cell
    }
    
    private func configure(withCell cell: UITableViewCell, tableView: UITableView, cellForRowAt indexPath: IndexPath) {
        let currentDepartment = departments[indexPath.row]
        cell.textLabel?.text = currentDepartment.departmentChineseName
        cell.detailTextLabel?.text = currentDepartment.departmentEnglishName
    }
}
