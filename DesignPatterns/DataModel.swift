//
//  DataModel.swift
//  
//
//  Created by Ross M Mooney on 10/2/15.
//
//

import Foundation
import ReactiveCocoa

// MARK: - Protocols
protocol MessageRefreshType {
}

protocol MessageSendType {
}

protocol UserInfoType {
}

protocol LeadInfoType {
}

// MARK: - Extensions (Default implementations)

extension MessageRefreshType {
    func refreshMessages() -> SignalProducer<(), RefreshError> {
        return SignalProducer { sink, disposable in
            //Do real processing here (call API)
            sendCompleted(sink)
        }
    }
}

extension MessageSendType {
    func sendMessage(message: String, phoneNumber: String) -> SignalProducer<(), SendError> {
        return SignalProducer { sink, disposable in
            sendCompleted(sink)
        }
    }
}

extension UserInfoType {
    func requestUserInfo() throws -> UserInfo {
        do {
            return try requestUserInfoFromCoreData()
        } catch let error {
            throw error
        }
    }
}

extension LeadInfoType {
    func requestLeadInfo(contactId: Int64) throws -> LeadInfo {
        do {
            return try requestLeadInfoFromCoreData(contactId)
        } catch let error {
            throw error
        }
    }
}

// MARK: - Error Types

enum RefreshError : ErrorType {
    case NetworkError
    case ServerError
}

enum SendError : ErrorType {
    case NetworkError
    case ServerError
}

enum UserInfoError : ErrorType {
    case CoreDataError
}

enum LeadInfoError: ErrorType {
    case CoreDataError
    case InvalidLeadError
}

// MARK: - Data Types

struct UserInfo {
    var firstName:String
    var lastName:String
    var phoneNumber:String
}

struct LeadInfo {
    var firstName:String
    var lastName:String
    var phoneNumbers:[String]
}

// MARK: - Private Functions

private func requestUserInfoFromCoreData() throws -> UserInfo {
    return UserInfo(firstName: "Johann", lastName: "Bach", phoneNumber: "1234567890")
}

private func requestLeadInfoFromCoreData(contactId: Int64) throws -> LeadInfo {
    switch contactId {
    case 0:
        throw LeadInfoError.InvalidLeadError
    case 1:
        return LeadInfo(firstName: "Jimmy", lastName: "John", phoneNumbers: ["1213345678", "1213345679"])
    default:
        throw LeadInfoError.InvalidLeadError
    }
}