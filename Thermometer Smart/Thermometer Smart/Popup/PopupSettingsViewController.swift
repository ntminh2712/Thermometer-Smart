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
    var listRingTone:[String] = ["Hello","Baby ","Warning"]
    @IBOutlet weak var heightTbRingTone: NSLayoutConstraint!
    
    
    var isShowTbRingTone: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func setupTableView() {
        tbRingTone.delegate = self
        tbRingTone.dataSource = self
        tbRingTone.register(UINib(nibName: "RingToneTableViewCell", bundle: nil), forCellReuseIdentifier: "RingToneTableViewCell")
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func disconnect(_ sender: Any) {
        
    }
    @IBAction func showSheetRingTone(_ sender: Any) {
        isShowTbRingTone != isShowTbRingTone
        handlerTbRingTone()
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
