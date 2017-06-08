//
//  ProfileViewController.swift
//  disrupt
//
//  Created by Lu, Michelle on 6/7/17.
//  Copyright © 2017 Annette Chen. All rights reserved.
//

import UIKit




class ProjectViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        var currentValue = Int(sender.value)
        
        label.text = "\(currentValue)"
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["Food", "Clothing", "Transportation", "Hotel", "Miscellaneous"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Project View"
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TitleText.text = pickerDataSource[row]
    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    
//    @available(iOS 2.0, *)
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    
//    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerDataSource.count;
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return pickerDataSource[row]
//    }
    

}
