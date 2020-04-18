//
//  IrisViewController.swift
//  Dev.FML
//
//  Created by Alejandro Espinoza on 17/04/20.
//  Copyright © 2020 Alejandro Espinoza. All rights reserved.
//

import UIKit

class IrisViewController: UIViewController {

    
    @IBOutlet weak var txtSepalLengthCm: UITextField!
    
    @IBOutlet weak var txtSepalWidthCm: UITextField!
    
    @IBOutlet weak var txtPetalLengthCm: UITextField!
    
    @IBOutlet weak var txtPetalWidthCm: UITextField!
    
    
    @IBOutlet weak var lblIris: UILabel!
    
    @IBOutlet weak var imgIris: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnGet(_ sender: Any) {
        
        let SepalLengthCm = Double( txtSepalLengthCm.text ?? "0")
        let SepalWidthCm = Double( txtSepalWidthCm.text ?? "0" )
        let PetalLengthCm = Double( txtPetalLengthCm.text ?? "0" )
        let PetalWidthCm = Double( txtPetalWidthCm.text ?? "0")
        
        
        
        let params : [String:Any] = [
            "SepalLengthCm": SepalLengthCm!,
            "SepalWidthCm": SepalWidthCm!,
            "PetalLengthCm": PetalLengthCm!,
            "PetalWidthCm": PetalWidthCm!
        ]
        
        self.imgIris.isHidden = true
        self.lblIris.isHidden = true
        
        Spinner.start()
        
        APIManager.shared.iris(params: params) { (json) in
            
            Spinner.stop()
            print(json)
            
            let result = json["result"].string!
            
            self.lblIris.text = result
            self.lblIris.isHidden = false
            self.imgIris.isHidden = false
            
            if result == "Iris-virginica" {
                
                self.imgIris.image = UIImage(named: "Iris-virginica")
            }
            
            if result == "Iris-setosa" {
                
                self.imgIris.image = UIImage(named: "Iris-setosa")
            }
            
            if result == "Iris-versicolor" {
                
                self.imgIris.image = UIImage(named: "Iris-versicolor")
            }
            
            
            
        }
        
        
        
    }
    
}
