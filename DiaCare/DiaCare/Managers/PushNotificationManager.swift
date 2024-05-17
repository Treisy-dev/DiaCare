//
//  PushNotificationManager.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 04.05.2024.
//

import Foundation
import UserNotifications

class PushNotificationManager: NSObject {

    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()

        notificationCenter.delegate = self
    }

    func registerForNotifications() async throws -> Bool {
        try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    }

}

extension PushNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }
}
