//
//  ViewController.swift
//  DesignPatterns
//
//  Created by Ross M Mooney on 10/1/15.
//  Copyright © 2015 BoomTown. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    var viewModel:InboxViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.viewModel = InboxViewModel()
        
        self.viewModel.inboxStateSignal.observeNext({ state in
            switch state {
            case .Default:
                self.view.backgroundColor = UIColor.blackColor()
            case .Waiting:
                self.view.backgroundColor = UIColor.yellowColor()
            case .Done:
                self.view.backgroundColor = UIColor.greenColor()
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        sendNext(self.viewModel.inboxRefreshSink, ())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clicked() {
      sendNext(self.viewModel.clickSink, ())
    }

}

