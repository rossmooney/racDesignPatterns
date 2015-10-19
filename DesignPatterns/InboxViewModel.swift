//
//  InboxViewModel.swift
//  DesignPatterns
//
//  Created by Ross M Mooney on 10/2/15.
//

import Foundation
import ReactiveCocoa


struct InboxViewModel: MessageRefreshType, LeadInfoType {
    
    var (refreshSignal, refreshSink) = Signal<(), NoError>.pipe()
    var (stateSignal, stateSink) = Signal<InboxState, NoError>.pipe()
    var disposable = CompositeDisposable()
    
    init() {
        sendNext(self.stateSink, .Default)
        self.refreshSignal.observeNext({ _ in
            sendNext(self.stateSink, .Waiting)
            let disposable = self.refreshMessages().start({ event in
                switch event {
                case .Completed:
                    print("Refresh Complete")
                    sendNext(self.stateSink, .Done)
                case .Error(let error):
                    print("Error occurred: \(error)")
                    sendNext(self.stateSink, .Error)
                default:break
                }
            
            })
            self.disposable.addDisposable(disposable)
        })
    }
}

enum InboxState {
    case Default
    case Waiting
    case Done
    case Error
}