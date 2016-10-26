//
//  ViewController.swift
//  DemoNotificaciones
//
//  Created by Core Data Media on 14/10/16.
//  Copyright © 2016 Core Data Media. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    
    func crearAttach(conNombre nombre : String, conTipo tipo : String) -> UNNotificationAttachment?{
        
        if let path = Bundle.main.path(forResource: nombre, ofType: tipo) {
            
            let url = URL(fileURLWithPath: path)
            
            do {
                
                let attach = try UNNotificationAttachment(identifier: nombre, url: url, options: nil)
                return attach
                
            }catch{
                
                print("No se encontro el recurso")
                return nil
            }
        }
        
        print("No se encontro el recurso")
        return nil
    }
    
    
    
    @IBAction func enviarNotificacion(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let centralNotificaciones = UNUserNotificationCenter.current()
        centralNotificaciones.delegate = appDelegate
        
        let contenido = UNMutableNotificationContent()
        contenido.title = "Titulo de mi notificación"
        contenido.subtitle = "Subtitulo de la notificación"
        contenido.body = "Este es mi primer mensaje de prueba en notificaciones para iOS 10 con Swift 3"
        contenido.userInfo = ["nombre" : "kenyi" , "apellido" : "Rodriguez"]
        
        //Solo para notificaciones custom
        contenido.categoryIdentifier = "myNotificationCategory"
        
        
        let recusoImagen = self.crearAttach(conNombre: "imagen", conTipo: "gif")
        if recusoImagen != nil {
            contenido.attachments = [recusoImagen!]
        }
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let peticion = UNNotificationRequest.init(identifier: "DemoNotificacion", content: contenido, trigger: trigger)
        
        centralNotificaciones.add(peticion) { (error) in
            
            if error == nil {
                
                print("Se agrego correctamente")
            }else{
                print("Se presento un problema")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

