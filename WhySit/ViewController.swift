//
//  ViewController.swift
//  WhySit
//
//  Created by Andrew McConnell on 4/25/17.
//  Copyright © 2017 Andrew McConnell. All rights reserved.
//

import UIKit
import CoreLocation
import ResearchKit
import CoreBluetooth
//import GoogleAPIClientForREST

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var survey: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    //@IBOutlet weak var tableView: UITableView!
    
    let arrayOfServices: [CBUUID] = [CBUUID(string: "8CB88C3B-E0B0-4448-B1D3-EE073DDA5941")]
    let state = UIApplication.shared.applicationState
    
    var centralManager: CBCentralManager?
    var peripherals = Array<CBPeripheral>()
    
    var count = 1
    
    var locationManager: CLLocationManager!
    
    var locationDone = false

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        survey.isEnabled = false
        submit.isEnabled = false
        
        print("View did load")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        determineMyCurrentLocation()
        
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        //manager.stopUpdatingLocation()
        //print("user latitude = \(userLocation.coordinate.latitude)")
        //print("user longitude = \(userLocation.coordinate.longitude)")
        
        //csvText += "\(userLocation.coordinate.latitude)" + ","
        //csvText += "\(userLocation.coordinate.longitude)" + "\n"
        longitude.text = String(format: "%f", userLocation.coordinate.longitude)
        latitude.text = String(format: "%f", userLocation.coordinate.latitude)
        //manager.stopUpdatingLocation()
        //locationDone = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showToast(message : String) {
        
        print("Creating toast")
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height/2-100, width: 200, height: 150))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 8.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        self.present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        self.present(taskViewController, animated: true, completion: nil)
    }

}

extension ViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        submit.isEnabled = true
        survey.isEnabled = false
        
        if (taskViewController.task?.identifier == "SurveyTask" && reason == .completed) {
            print("Starting results")
            
            let fileName = "Survey" + String(count)
            count += 1
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("csv")
            print("FilePath: \(fileURL.path)")
            var csvText = "Q1,Q2,Q3,Q4,Q5,Q6a,Q6b,Q6c,Q6d,Q7a,Q7b,Latitude,Longitude\r\n"
            
            
            let taskResultValue = taskViewController.result
            //print("Survey started at : \(taskResultValue.startDate)     Ended at : \(taskResultValue.endDate)")
            //2
            if let q1StepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep")
            {
                let ans = (q1StepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 1 Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            if let q2StepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep2")
            {
                let ans = (q2StepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 2 Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            else {csvText += "NA,"}
            if let q3StepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep3")
            {
                let arr = q3StepResult.results?[0].value(forKey: "answer")! as! NSArray
                var ans = "("
                for val in arr {
                    print("Question 3 Answer: \(val)")
                    ans += (val as! NSNumber).stringValue + "/"
                }
                csvText += ans
                csvText += "),"
            }
            else {csvText += "NA,"}
            if let q4StepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep4")
            {
                let ans = (q4StepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 4 Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            else {csvText += "NA,"}
            if let q5StepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep5")
            {
                let arr = q5StepResult.results?[0].value(forKey: "answer")! as! NSArray
                //let ans = (arr as AnyObject).stringValue + ","
                var ans = "("
                for val in arr {
                    print("Question 5 Answer: \(val)")
                    ans += (val as! NSNumber).stringValue + "/"
                }
                csvText += ans
                csvText += "),"
            }
            if let q6aStepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep6a")
            {
                let ans = (q6aStepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 6a Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            else {csvText += "NA,"}
            if let q6bStepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep6b")
            {
                let ans = (q6bStepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 6b Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            else {csvText += "NA,"}
            if let q6cStepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep6c")
            {
                let ans = (q6cStepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 6c Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            else {csvText += "NA,"}
            if let q6dStepResult = taskResultValue.stepResult(forStepIdentifier: "TextChoiceQuestionStep6d")
            {
                let ans = (q6dStepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 6d Answer: \(ans)")
                csvText += (ans as AnyObject).stringValue + ","
            }
            else {csvText += "NA,"}
            if let e1dStepResult = taskResultValue.stepResult(forStepIdentifier: "ImageChoiceQuestionStep")
            {
                let ans = (e1dStepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 7a Answer: \(ans)")
                csvText += ans as! String + ","
            }
            if let e2StepResult = taskResultValue.stepResult(forStepIdentifier: "ImageChoiceQuestionStep2")
            {
                let ans = (e2StepResult.results?[0].value(forKey: "answer")! as! NSArray)[0]
                print("Question 7b Answer: \(ans)")
                csvText += ans as! String + ","
            }
            csvText += latitude.text! + ","
            csvText += longitude.text! // + "\n"
            
            do {
                // Write to the file
                try csvText.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
            }
            
        }
            taskViewController.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func submitTapped(sender : AnyObject) {
        submit.isEnabled = false
        var readString = "" // Used to store the file contents
        let fileName = "Survey"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("csv")
        do {
            // Read the file contents
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        print("File Text: \(readString)")
    }

}

extension ViewController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        if (central.state == .poweredOn){
            //print("here")
            self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            print("BLE not enabled")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Scanning for peripherals")
 
        if (peripheral.name != nil) {
            showToast(message: "Survey requested!")
            print("Peripheral discovered")
            print(peripheral.name! as Any)
            print("\(advertisementData)".components(separatedBy: "\n")[0]) //.valueForKey("kCBAdvDataIsConnectable"))
            //if ((peripheral.name!.range(of: "Andrew’s MacBook Pro")) != nil) { // may need to fix name
            peripherals.append(peripheral)
            print(peripheral.services as Any)
            print("Connecting...")
                //if watch...centralManager.connectPeripheral(peripheral, options: nil)
            centralManager?.connect(peripheral, options: nil)
            print(peripheral.identifier)
            centralManager?.stopScan()
            survey.isEnabled = true
                //peripheral.readValue(for: a) //CBCharacteristic??*/
            //}
        }
    }
    
    // Called when connection succeeded
    func centralManager(central: CBCentralManager,
                        didConnectPeripheral peripheral: CBPeripheral) {
        print("Connected!")
    }
    // Called when connection failed
    func centralManager(_ central: CBCentralManager,
                        didFailToConnect peripheral: CBPeripheral,
                        error: Error?) {
        print("Failed…")
    }
}


