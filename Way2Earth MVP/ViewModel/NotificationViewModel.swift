//
//  NotificationViewModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 4/3/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

struct NotificationViewModel {
    let notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl : URL? { return URL(string: notification.postImageUrl ?? "") }
    
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl )}
    
    var notificationUserName: String { return notification.userName }
    
    var notificationMessage: String { return notification.type.notificationMessage }
    
    var shouldHidePostImage: Bool { return self.notification.type == .follow }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? "2m"
    }
    
}
