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

public protocol Updatable {

    func update(data: AnyObject)
}

public protocol TableViewDelegate: class {
    
    func configure(cell: UITableViewCell, tableview: UITableView, indexPath: IndexPath, data: AnyObject)
    func didSelect(tableView tableview: UITableView, indexPath: IndexPath, data: AnyObject)
}

public protocol TableViewDataSource: class {
    
    func cellIdentifier(forData data: AnyObject) -> String?
}

public protocol TableViewSectionHeaderDelegate: class {

    func sectionView(forSection section: Int) -> UIView?
    func height(forSection section: Int) -> CGFloat

}

public protocol TableViewScrollDelegate: class {

    func didScroll(_ scrollView: UIScrollView)
    func didEndScrolling(_ scrollView: UIScrollView)
    
}

open class GangTableView: UITableView {

    open var sections = [[AnyObject]]()
    open weak var tableViewDelegate: TableViewDelegate?
    open weak var tableViewDataSource: TableViewDataSource?
    open weak var tableViewScrollDelegate: TableViewScrollDelegate?
    open weak var tableViewSectionHeaderDelegate: TableViewSectionHeaderDelegate?

    fileprivate var registeredIdentifiers = Set<String>()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        dataSource = self
    }

    func data(atIndexPath indexPath: IndexPath) -> AnyObject {
        return sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
    }
}

extension GangTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        tableViewDelegate?.didSelect(tableView: self, indexPath: indexPath, data: data)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableViewScrollDelegate?.didScroll(self)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tableViewScrollDelegate?.didEndScrolling(self)
    }
}

extension GangTableView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        if let identifier = tableViewDataSource?.cellIdentifier(forData: data) {
            
            if registeredIdentifiers.contains(identifier) == false {
                
                if let _ = Bundle.main.path(forResource: identifier, ofType: "nib") {
                    
                    let nib = UINib(nibName: identifier, bundle: nil)
                    register(nib, forCellReuseIdentifier: identifier)
                    registeredIdentifiers.insert(identifier)

                } else {
                    
                    return UITableViewCell()
                }
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            
            if let cell = cell as? Updatable {
                cell.update(data: data)
            }

            tableViewDelegate?.configure(cell: cell, tableview: tableView, indexPath: indexPath, data: data)

            return cell
        }
        
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewSectionHeaderDelegate?.sectionView(forSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSectionHeaderDelegate?.height(forSection: section) ?? UITableViewAutomaticDimension
    }
}
