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

    func update(data data: AnyObject)
}

public protocol TableViewDelegate: class {
    
    func configure(cell cell: UITableViewCell, tableview: UITableView, indexPath: NSIndexPath, data: AnyObject)
    func didSelect(tableView tableview: UITableView, indexPath: NSIndexPath, data: AnyObject)
}

public protocol TableViewDataSource: class {
    
    func cellIdentifier(forData data: AnyObject) -> String?
}

public protocol TableViewSectionHeaderDelegate: class {

    func sectionView(forSection section: Int) -> UIView?
    func height(forSection section: Int) -> CGFloat

}

public protocol TableViewScrollDelegate: class {

    func didScroll(scrollView: UIScrollView)
    func didEndScrolling(scrollView: UIScrollView)
    
}

public class GangTableView: UITableView {

    public var sections = [[AnyObject]]()
    public weak var tableViewDelegate: TableViewDelegate?
    public weak var tableViewDataSource: TableViewDataSource?
    public weak var tableViewScrollDelegate: TableViewScrollDelegate?
    public weak var tableViewSectionHeaderDelegate: TableViewSectionHeaderDelegate?

    private var registeredIdentifiers = Set<String>()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        dataSource = self
    }

    func data(atIndexPath indexPath: NSIndexPath) -> AnyObject {
        return sections[indexPath.section][indexPath.row]
    }
}

extension GangTableView: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let data = sections[indexPath.section][indexPath.row]
        tableViewDelegate?.didSelect(tableView: self, indexPath: indexPath, data: data)
    }

    public func scrollViewDidScroll(scrollView: UIScrollView) {
        tableViewScrollDelegate?.didScroll(self)
    }

    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        tableViewScrollDelegate?.didEndScrolling(self)
    }
}

extension GangTableView: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
            
            if let cell = cell as? Updatable {
                cell.update(data: data)
            }

            tableViewDelegate?.configure(cell: cell, tableview: tableView, indexPath: indexPath, data: data)

            return cell
        }
        
        return UITableViewCell()
    }

    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewSectionHeaderDelegate?.sectionView(forSection: section)
    }

    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSectionHeaderDelegate?.height(forSection: section) ?? UITableViewAutomaticDimension
    }
}
