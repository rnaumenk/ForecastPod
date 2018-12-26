//
//  ViewController.swift
//  ForecastPod
//
//  Created by Ruslan on 12/26/18.
//  Copyright © 2018 Ruslan Naumenko. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    private var bot : RecastAIClient?
    private var client : DarkSkyClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bot = RecastAIClient(token : "f589b42d1f05e638e5073a469cd52cf7")
        self.client = DarkSkyClient(apiKey: "0b188dfa3767c06bf8cb355510c05ef8")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func makeRequest()
    {
        if (!(self.textField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty)!) {
            self.bot?.textRequest(self.textField.text!, successHandler: recastRequestDone, failureHandle: recastRequestFailed)
        }
    }
    
    private func recastRequestDone(_ response : Response)
    {
        let location = response.get(entity: "location")
        if let loc = location {
            answerLabel.text = ("\(loc["formatted"] as! String)\n\(loc["lat"] as! NSNumber), \(loc["lng"] as! NSNumber)")
            client?.getForecast(latitude: loc["lat"] as! Double, longitude: loc["lng"] as! Double) { result in
                switch result {
                case .success(let currentForecast, _):
                    DispatchQueue.main.async {
                        self.answerLabel.text = String(self.answerLabel.text! + "\n\n" + (currentForecast.daily?.summary)!)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        else {
            answerLabel.text = "Error"
        }
    }
    
    private func recastRequestFailed(_ error : Error) {
        answerLabel.text = "Error"
    }
    
    @IBAction func requestButton(_ sender: UIButton) {
        makeRequest()
    }
    
}
