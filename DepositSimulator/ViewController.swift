//
//  ViewController.swift
//  DepositSimulator
//
//  Created by 田中良明 on 2018/06/01.
//  Copyright © 2018年 tanakayoshiaki. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UITextFieldDelegate,GADBannerViewDelegate {

    var bannerView: GADBannerView!
    
    @IBOutlet weak var years: UILabel!
    

    @IBOutlet weak var target: UITextField!
    @IBOutlet weak var now: UITextField!
    @IBOutlet weak var reserve: UITextField!

    @IBOutlet weak var reaching: UILabel!
    
    @IBOutlet weak var calButton: UIButton!
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Google Mobile Ads SDK version:\(GADRequest.sdkVersion())")
        // デフォルト値
        userDefaults.register(defaults: ["target": "1" ])
        userDefaults.register(defaults: ["now": "1" ])
        userDefaults.register(defaults: ["reserve": "1" ])
        
        // Keyを指定して読み込み
        target.text = (userDefaults.object(forKey: "target") as! String)
        now.text = (userDefaults.object(forKey: "now") as! String)
        reserve.text = (userDefaults.object(forKey: "reserve") as! String)

        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        self.target.keyboardType = UIKeyboardType.numberPad
        self.now.keyboardType = UIKeyboardType.numberPad
        self.reserve.keyboardType = UIKeyboardType.numberPad
        target.delegate = self
        now.delegate = self
        reserve.delegate = self

        //contentInsetAdjustmentBehavior
        //reaching.
        //reaching.setContentOffset(CGPointZero, animated: false)
        //target = UITextField()
        //target.text = "0"
        //target.addTarget(self, action: Selector(("textFieldDidChange:")),for: UIControlEvents.editingChanged)
        //target.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    

        
        bannerView.adUnitID = "ca-app-pub-6789227322694215/4329219297"
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"//test
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        calculate(0)
    }
    
    @IBAction func targetcal(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(target.text, forKey: "target")
        calculate(0)
    }
    @IBAction func nowcal(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(now.text, forKey: "now")
        calculate(0)
    }
    @IBAction func reservecal(_ sender: UITextField) {
        // Keyを指定して保存
        userDefaults.set(reserve.text, forKey: "reserve")
        calculate(0)
    }
    
    
    /*@objc func textFieldDidChange(_ target: UITextField) {
        //target.text = "0"
        //print(textFiled.text ?? 0)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func calculate(_ sender: Any) {
        // データの同期
        userDefaults.synchronize()
        
        let resultTarget:Int? = Int(target.text!)
        let resultNow:Int? = Int(now.text!)
        let resultReserve:Int? = Int(reserve.text!)
        
        if resultTarget != nil && resultNow != nil && resultReserve != nil {
            
            if resultReserve != 0{
                var month = ((resultTarget!-resultNow!)/resultReserve!)
                let year = month / 12
                month = month % 12
                years.text = String(year) + "年" + String(month) + "か月"
                let text:String = "半年後："+String(resultNow! + 6 * resultReserve!)+"万円"
                    + "\n１年後："+String(resultNow! + 12 * resultReserve!)+"万円"
                    + "\n２年後："+String(resultNow! + 2*12 * resultReserve!)+"万円"
                    + "\n３年後："+String(resultNow! + 3*12 * resultReserve!)+"万円"
                    + "\n４年後："+String(resultNow! + 4*12 * resultReserve!)+"万円"
                    + "\n５年後："+String(resultNow! + 5*12 * resultReserve!)+"万円"
                    + "\n１０年後："+String(resultNow! + 10*12 * resultReserve!)+"万円"
                    + "\n１５年後："+String(resultNow! + 15*12 * resultReserve!)+"万円"
                    + "\n２０年後："+String(resultNow! + 20*12 * resultReserve!)+"万円"
                    + "\n３０年後："+String(resultNow! + 30*12 * resultReserve!)+"万円"
                    + "\n４０年後："+String(resultNow! + 40*12 * resultReserve!)+"万円"
                    + "\n５０年後："+String(resultNow! + 50*12 * resultReserve!)+"万円"
                reaching.text = text
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}

