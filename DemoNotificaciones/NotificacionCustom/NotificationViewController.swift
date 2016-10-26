//
//  NotificationViewController.swift
//  NotificacionCustom
//
//  Created by Core Data Media on 14/10/16.
//  Copyright © 2016 Core Data Media. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    
    @IBOutlet weak var imgFoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        guard let attachment  = notification.request.content.attachments.first else {
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            
            let dataImagen = try? Data.init(contentsOf: attachment.url)
            if let img = dataImagen {
                self.imgFoto.image = UIImage(data: img)
            }
        }
        
    }

}
