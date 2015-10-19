//
//  ViewController.swift
//  DesignPatterns
//
//  Created by Ross M Mooney on 10/1/15.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    var viewModel:InboxViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.viewModel = InboxViewModel()
        
        self.viewModel.stateSignal.observeNext({ state in
            switch state {
            case .Default:
                self.view.backgroundColor = UIColor.blackColor()
            case .Waiting:
                self.view.backgroundColor = UIColor.yellowColor()
            case .Done:
                self.view.backgroundColor = UIColor.greenColor()
            case .Error:
                self.view.backgroundColor = UIColor.redColor()
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        sendNext(self.viewModel.refreshSink, ())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clicked() {
    }

}

