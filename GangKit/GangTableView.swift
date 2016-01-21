//
//  CustomTableView.swift
//  TableViewSwiftPoC
//
//  Created by Ricki Gregersen on 15/01/16.
//  Copyright © 2016 youandthegang.com. All rights reserved.
//

/** Example ViewController

// Make .Nib cell with same name as identifier e.g. "TitleCell.nib" must have identifier "TitleCell"

class ViewController: UIViewController {

    @IBOutlet weak var tableView: CustomTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.sections = [["Title 00", "Title 01"], ["Title 10", "Title 11"]]
        tableView.customTableViewDataSource = self
        tableView.customTableViewDelegate = self
    }
}

extension ViewController: CustomTableViewDataSource {

    func cellIdentifier(forData data: AnyObject) -> String? {

        switch data {
        case is String:
            return "TitleCell"
        default:
            return ""
        }
    }
}

extension ViewController: CustomTableViewDelegate {

    func didSelect(tableView tableview: UITableView, indexPath: NSIndexPath, data: AnyObject) {

    }
}

*/

import UIKit

public protocol UpdatableCell {

    func update(data data: AnyObject)
}

public protocol TableViewDelegate: class {
    
    func didSelect(tableView tableview: UITableView, indexPath: NSIndexPath, data: AnyObject)
    
}

public protocol TableViewDataSource: class {
    
    func cellIdentifier(forData data: AnyObject) -> String?
}

public class GangTableView: UITableView {

    var sections = [[AnyObject]]()
    private var registeredIdentifiers = Set<String>()
    
    weak var tableViewDelegate: TableViewDelegate?
    weak var tableViewDataSource: TableViewDataSource?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        dataSource = self
    }
}

extension GangTableView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let data = sections[indexPath.section][indexPath.row]
        tableViewDelegate?.didSelect(tableView: self, indexPath: indexPath, data: data)
    }
}

extension GangTableView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let data = sections[indexPath.section][indexPath.row]
        
        if let identifier = tableViewDataSource?.cellIdentifier(forData: data) {
            
            if registeredIdentifiers.contains(identifier) == false {
                
                if let _ = NSBundle.mainBundle().pathForResource(identifier, ofType: "nib") {
                    
                    let nib = UINib(nibName: identifier, bundle: nil)
                    registerNib(nib, forCellReuseIdentifier: identifier)
                    registeredIdentifiers.insert(identifier)

                } else {
                    
                    return UITableViewCell()
                }
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if let cell = cell as? UpdatableCell {
                cell.update(data: data)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
