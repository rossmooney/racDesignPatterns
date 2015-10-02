//
//  InboxViewModel.swift
//  DesignPatterns
//
//  Created by Ross M Mooney on 10/2/15.
//

import Foundation
import ReactiveCocoa


class InboxViewModel : DataModel {
    //Inputs
    let (inboxRefreshSignal, inboxRefreshSink) = Signal<(), NoError>.pipe()
    let (clickSignal, clickSink) = Signal<(), NoError>.pipe()
    
    //Outputs
    let (inboxStateSignal, inboxStateSink) = Signal<InboxState, NoError>.pipe()
    
    override init() {
        super.init()
        
        sendNext(self.inboxStateSink, InboxState.Default)
        combineLatest(self.inboxRefreshSignal, self.clickSignal).observeNext({_ in
            sendNext(self.inboxStateSink, InboxState.Waiting)
            sendNext(self.refreshMessagesSink, ())
            sendNext(self.reloadContactsSink, ())
        })
        
        self.contactsUpdateStateSignal.observeNext({ state in
            switch state {
            case .Complete:
                sendNext(self.inboxStateSink, InboxState.Done)
            case .Error:
                sendNext(self.inboxStateSink, InboxState.Done)
            case .InProgress:
                sendNext(self.inboxStateSink, InboxState.Waiting)
            }
        })
    }
}

enum InboxState {
    case Default
    case Waiting
    case Done
}