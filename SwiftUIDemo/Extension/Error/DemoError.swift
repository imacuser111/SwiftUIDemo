//
//  QppError.swift
//  Qpp
//
//  Created by hsu tzu Hsuan on 2020/10/6.
//

import Foundation

// MARK: - extension Error

extension Error {
    /// Error to QppError.ResponseErrorReason (responseFailed)
    var responseError: GashTicketsError.ResponseErrorReason? {
        if let error = self as? GashTicketsError {
            switch error {
            case .responseFailed(reason: let reason):
                return reason
            default:
                return nil
            }
        }
        return nil
    }
    
    /// Error string
    var errorDescription: String? {
        if let error = self as? GashTicketsError {
            return error.errorDescription
        } else if let error = self as? URLError {
            switch error.code {
            case .notConnectedToInternet, .timedOut:
                return LocalizationList.ID_CheckAndRetryInternet
            default:
                return nil
            }
        }
        return nil
    }
    
    /// 給外部判斷錯誤碼
    var errorCode: Int? {
        if let error = self as? GashTicketsError {
            switch error {
            case .responseFailed(let reason):
                return reason.errorCode
            case .generalError(let reason):
                return reason.errorCode
            default:
                return nil
            }
        }
        return nil
    }
}


// MARK: - Error

public enum GashTicketsError: Error {
    
    public enum GeneralErrorReason {
        /// Cannot convert `string` to valid data with `encoding`. Code 4001.
        case conversionError(string: String, encoding: String.Encoding)

        /// The method is invoked with an invalid parameter. Code 4002.
        case parameterError(parameterName: String, description: String)
        
        case httpError(errorCode:Int)
    }

    public enum ResponseErrorReason {
        /// An error occurred in the underlying `URLSession` object. Code 2001.
        case URLSessionError(Error)

        /// The response is not a valid `HTTPURLResponse` object. Code 2002.
        case nonHTTPURLResponse(Error?)
        /// The received data cannot be parsed to an instance of the target type. Code 2003.
        /// - Associated values: Parsing destination type, original data, and system underlying error.
        case dataParsingFailed(Any.Type, Data, Error?)
        
        case serverFeedbackError(errorCode: Int, failString: String = "")
    }

    /// An error occurred while handling a response.
    case responseFailed(reason: ResponseErrorReason)
    
    /// An error occurred while performing another process in the LINE SDK.
    case generalError(reason: GeneralErrorReason)
    
    
    /// An error not defined in the LINE SDK occurred.
    case untypedError(error: Error)
    
    /// NoNetowrk error
    case noNetworkError
}

/// MARK: - Error description
extension GashTicketsError: LocalizedError {
    /// Describes the cause of an error in human-readable text.
    public var errorDescription: String? {
        switch self {
        case .responseFailed(reason: let reason): return reason.errorDescription
        case .generalError(reason: let reason): return reason.errorDescription
        case .untypedError(error: let error): return "An error not typed inside: \(error)"
        case .noNetworkError: return "StringList.ID_NotConnected"
        }
    }
}

extension GashTicketsError.ResponseErrorReason {
    
    var errorDescription: String? {
        switch self {
        case .URLSessionError(let error):
            return "URLSession task finished with error: \(error)"
        case .nonHTTPURLResponse(let error):
            return error?.localizedDescription
        case .dataParsingFailed(let type, let data, let error):
            let errorMessage = error != nil ? "\(error!)" : "<nil>"
            let result = "Parsing response data to \(type) failed: \(errorMessage)."
            if let text = String(data: data, encoding: .utf8) {
                return result + "\nOriginal: \(text)"
            } else {
                return result
            }
        case .serverFeedbackError(_, let failString):
            return failString
        }
    }
    
    var errorCode: Int {
        switch self {
        case .URLSessionError:           return -2001
        case .nonHTTPURLResponse:        return -2002
        case .dataParsingFailed:         return -2003
        case .serverFeedbackError(let errorCode, _): return errorCode
        default: return 0
        }
    }
}

extension GashTicketsError.GeneralErrorReason {
    
    var errorDescription: String? {
        switch self {
        case .conversionError(let text, let encoding):
            return "Cannot convert target \"\(text)\" to valid data under \(encoding) encoding."
        case .parameterError(let parameterName, let reason):
            return "Method invoked with an invalid parameter \"\(parameterName)\". Reason: \(reason)"
        case .httpError(let errorCode):
            return "http code :\(errorCode)"
        }
    }
    
    var errorCode: Int {
        switch self {
        case .conversionError(_, _): return 4001
        case .parameterError(_, _):  return 4002
        case .httpError(let error):  return error
        }
    }
}
