//
//  UITableView+Extension.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit


protocol ReusableView {
    
}
extension ReusableView where Self:UIView{
    static var reuseIdentifier:String{
        return String(describing: self)
    }
}

protocol NibLoadableView {
    
}
extension NibLoadableView where Self:UIView{
    static var NibName:String{
        return String(describing: self)
    }
}

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
    func register<T:UITableViewCell> (_: T.Type) where T:ReusableView, T:NibLoadableView{
        let nib = UINib(nibName: T.NibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell <T: UITableViewCell>(forIndexPath indexPath:IndexPath) -> T where T:ReusableView {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else{
            fatalError("Could not dequeue table cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
        
    }
    
    func register<T:UITableViewHeaderFooterView> (_: T.Type) where T:ReusableView, T:NibLoadableView{
        let nib = UINib(nibName: T.NibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReuseHeaderFooterView<T:UITableViewHeaderFooterView>() -> T where T:ReusableView{
        guard let reuseView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else{
            fatalError("Could not dequeue table header view with identifier: \(T.reuseIdentifier)")
        }
        
        return reuseView
    }
}
extension UITableViewCell:ReusableView,NibLoadableView{
    func backgroundSelect(color: UIColor)
    {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        self.selectedBackgroundView = backgroundView
    }

}
