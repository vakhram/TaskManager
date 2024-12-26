//
//  DateFormatter+Extension.swift
//  TaskManager
//
//  Created by Guest Acc on 26.12.2024.
//

import Foundation

extension DateFormatter {
    enum SelfType {
        case date
        case time
    }
    
    static func createdateFormatter(with type: SelfType) -> DateFormatter {
        let formatter = DateFormatter()
        
        switch type {
        case .date:
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            
        case .time:
            formatter.dateStyle = .none
            formatter.timeStyle = .short
        }
        
        return formatter
    }
}
