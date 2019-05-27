//
//  PopupSettingsViewController.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import UIKit

class PopupSettingsViewController: UIViewController {

    @IBOutlet weak var swWarning: UISwitch!
    @IBOutlet weak var lbNameSong: UILabel!
    @IBOutlet weak var tbRingTone: UITableView!
    @IBOutlet weak var heightTbRingTone: NSLayoutConstraint!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewDetail: UIView!
    
    var listRingTone:[String] = ["Hello","Baby ","Warning"]
    
    var isShowTbRingTone: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupupView()
        setupTableView()
        handlerTbRingTone()
    }
    
    func setupupView(){
        viewTitle.frame = CGRect(x: 0, y: 0, width: (self.view.frame.width - 40), height: 50)
        viewTitle.layer.masksToBounds = false
        viewDetail.frame = CGRect(x: 0, y: 0, width: (self.view.frame.width - 40), height: 250)
        viewDetail.layer.masksToBounds = false
        viewTitle.roundCorners(corners: [.topLeft,.topRight], radius: 5)
        viewDetail.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
    }
    
    func setupTableView() {
        tbRingTone.delegate = self
        tbRingTone.dataSource = self
        tbRingTone.register(UINib(nibName: "RingToneTableViewCell", bundle: nil), forCellReuseIdentifier: "RingToneTableViewCell")
    }
    
    @IBAction func disconnect(_ sender: Any) {
        NotificationCenter.default.post(name: notificationName.disconnected.notification, object: nil)
    }
    @IBAction func showSheetRingTone(_ sender: Any) {
        isShowTbRingTone != isShowTbRingTone
        handlerTbRingTone()
    }
    @IBAction func disablePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func handlerTbRingTone(){
        if isShowTbRingTone {
            heightTbRingTone.constant = 0
        }else {
            heightTbRingTone.constant = 0
        }
    }
    

}
extension PopupSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRingTone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RingToneTableViewCell") as! RingToneTableViewCell
        cell.lbNameRings.text = listRingTone[indexPath.row]
        cell.selectRingTone = { [weak self]  in
            self?.isShowTbRingTone != self?.isShowTbRingTone
            self?.handlerTbRingTone()
        }
        return cell
    }
}

extension UIView{
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
