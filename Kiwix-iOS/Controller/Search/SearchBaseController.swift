//
//  SearchBaseController.swift
//  Kiwix
//
//  Created by Chris Li on 11/14/16.
//  Copyright © 2016 Chris Li. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class SearchBaseTableController: CoreDataTableBaseController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.emptyDataSetSource = nil
        tableView.emptyDataSetDelegate = nil
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: NSValue],
            let origin = userInfo[UIKeyboardFrameEndUserInfoKey]?.cgRectValue.origin else {return}
        let point = view.convert(origin, from: nil)
        let buttomInset = view.frame.height - point.y
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0, buttomInset, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0, buttomInset, 0)
        tableView.reloadEmptyDataSet()
    }
    
    func keyboardWillHide(notification: Notification) {
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0, 0, 0)
        tableView.reloadEmptyDataSet()
    }
}
