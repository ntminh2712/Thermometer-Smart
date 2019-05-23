//
//  TemperatureViewController.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import UIKit
import Charts
class TemperatureViewController: UIViewController, TemperatureView {
    
    @IBOutlet weak var imgMinTemprate: UIImageView!
    @IBOutlet weak var imgMaxTemprate: UIImageView!
    @IBOutlet weak var bgProcess: UIImageView!
    @IBOutlet weak var lbTemarate: UILabel!
    @IBOutlet weak var imgArrowProcess: UIView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    //    @IBOutlet var chartView: LineChartView!
    @IBOutlet weak var lbNameDevice: UILabel!
    @IBOutlet weak var lbMac: UILabel!
    @IBOutlet weak var lbPinDevice: UILabel!
    
    private var listTemperature: [TemperatureEntity] = []
    private var temperature: Int = 0
    var presenter: TemperaturePeresenter?
    var config: TemperatureConfiguration = TemperatureConfigurationImplementation()
    override func viewDidLoad() {
        super.viewDidLoad()
        config.configure(temperatureControler: self)
        presenter?.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(noticationDataDevice), name: notificationName.dataThermomete.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showNotConnect), name: notificationName.showNotConnected.notification, object: nil)
        setData()
    }
    
    func showData (value: Double){
        DispatchQueue.main.async {
            print(value)
            self.lbTemarate.text = "\(String(format: "%.1f", value))°C"
            self.lbDate.text = Date().convertDateToStringWithDateFormat(dateFormat: "dd/MM/yyyy")
            self.lbTime.text = Date().convertDateToStringWithDateFormat(dateFormat: "HH:mm")
            UIView.animate(withDuration: 1.5, animations: ({
                self.imgArrowProcess.transform = CGAffineTransform(rotationAngle: self.getDegrees(temperature: value))
            }))
        }
    }
    func setData(){
        guard DataSingleton.peripheralSelect != nil else { return }
        lbNameDevice.text = DataSingleton.peripheralSelect?.name
        lbMac.text = DataSingleton.peripheralSelect?.macAddress
    }
    
    @objc func noticationDataDevice(_ notification: NSNotification)
    {
        if let temperature = notification.userInfo?["temperature"] as? Double {
            self.showData(value: Double(temperature / 100))
        }
    }
    
    @objc func showNotConnect(){
        let alert = UIAlertController(title: "Messsage", message: "Do not connect to device", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func showSettings(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "popupSettings") as! PopupSettingsViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    //    func setDataCount(_ count: Int, range: UInt32) {
    //        let strDateStart = Date().convertDateToStringWithDateFormat(dateFormat: "yyyy-MM-dd 00:00:00")
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //        let date = dateFormatter.date(from: strDateStart!)
    //        let values = (0..<count).map { (i) -> ChartDataEntry in
    //            let dateAdd = Calendar.current.date(byAdding: .second, value: 60 * i, to: date!)!;
    //            let temperature = TemperatureEntity.getTemperatureEntity(uiid: (baby?.id)!, date: dateAdd)
    //            if temperature == nil
    //            {
    //                return ChartDataEntry(x: Double(i), y: Double(0), date: dateAdd)
    //            }
    //            else
    //            {
    //                return ChartDataEntry(x: Double(i), y: temperature!.value, date: dateAdd)
    //            }
    //        }
    //
    //        let set1 = LineChartDataSet(values: values, label: nil)
    //
    //        let n = values.count / (4 * 60)
    //        set1.drawValuesEnabled = false
    //        set1.drawCirclesEnabled = false
    //        set1.mode = .linear
    //        set1.setColor(#colorLiteral(red: 0.5529411765, green: 0.5921568627, blue: 0.6117647059, alpha: 1))
    //        set1.lineWidth = 0.5
    //        set1.valueFont = .systemFont(ofSize: 9)
    //        set1.formLineWidth = 1
    //        set1.formSize = 15
    //        set1.fillAlpha = 1
    //
    //        set1.fill = Fill(color: #colorLiteral(red: 0.5137254902, green: 0.8549019608, blue: 0.8941176471, alpha: 1))
    //        set1.drawFilledEnabled = true
    //
    //        let data = LineChartData(dataSet: set1)
    //        var indexScroll = Calendar.current.dateComponents([.minute], from: date!, to: Date()).minute!
    //        chartView.data = data
    //        chartView.setScaleMinima(CGFloat(n), scaleY: 1)
    //        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
    //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
    //            if indexScroll > 60
    //            {
    //                indexScroll -= 60
    //            }
    //            self.chartView.moveViewToX(Double(indexScroll))
    //        })
    //        chartView.data!.highlightEnabled = false
    //    }
    
    private func getDegrees(temperature: Double) -> CGFloat
    {
        if temperature < 30 || temperature > 46
        {
            return 0
        }
        else
        {
            return  CGFloat(Double(temperature - 30) * 22.5 / 180 * Double.pi)
        }
    }
}

//extension TemperatureViewController: ChartViewDelegate
//{
//    func setup(barLineChartView chartView: BarLineChartViewBase) {
//        chartView.chartDescription?.enabled = false
//
//        chartView.dragEnabled = true
//        chartView.setScaleEnabled(true)
//        chartView.pinchZoomEnabled = false
//
//        // ChartYAxis *leftAxis = chartView.leftAxis;
//
//        let xAxis = chartView.xAxis
//        xAxis.labelPosition = .bottom
//
//        chartView.rightAxis.enabled = false
//    }
//    // TODO: Cannot override from extensions
//    //extension DemoBaseViewController: ChartViewDelegate {
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        NSLog("chartValueSelected");
//    }
//
//    func chartValueNothingSelected(_ chartView: ChartViewBase) {
//        NSLog("chartValueNothingSelected");
//    }
//
//    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
//
//    }
//
//    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
//
//    }
//}
