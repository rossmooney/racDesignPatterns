//
//  DataModel.swift
//  
//
//  Created by Ross M Mooney on 10/2/15.
//
//

import Foundation
import ReactiveCocoa

class DataModel {
    
    //Inputs
    let (refreshMessagesSignal, refreshMessagesSink) = Signal<(), NoError>.pipe()
    let (reloadContactsSignal, reloadContactsSink) = Signal<(), NoError>.pipe()
    
    //Outputs
    let (contactsUpdateStateSignal, contactsUpdateStateSink) = Signal<ContactsUpdateState, NoError>.pipe()
    
    init() {
        self.refreshMessagesSignal.observeNext({_ in self.refreshMessages() })
        self.reloadContactsSignal.observeNext({_ in self.reloadContacts() })
    }
    
    func refreshMessages() {
        print("refreshingMessages")
    }
    
    func reloadContacts() {
        print("reloading contacts")
        sendNext(self.contactsUpdateStateSink, ContactsUpdateState.InProgress)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("finished reloading contacts")
            sendNext(self.contactsUpdateStateSink, ContactsUpdateState.Complete)

        }
    }
}



enum ContactsUpdateState {
    case InProgress
    case Complete
    case Error
}