//
//  ViewController.swift
//  plugAndPlay
//
//  Created by Chih-Hao on 2017/8/27.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import Cocoa
import CoreAudio
class ViewController: NSViewController {

       
    @IBAction func openApp(_ sender: Any) {
        
        
        NSWorkspace.shared().open(URL(fileURLWithPath: "/Applications/NeteaseMusic.app"))
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0, execute:  {
            
            let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
            
            let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: true)
            let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: false)
            let spcd = CGEvent(keyboardEventSource: src, virtualKey: 0x23, keyDown: true)
            let spcu = CGEvent(keyboardEventSource: src, virtualKey: 0x23, keyDown: false)
            
//            let opsd = CGEvent(keyboardEventSource: src, virtualKey: 0x3A, keyDown: true)
//            let opsu = CGEvent(keyboardEventSource: src, virtualKey: 0x3A, keyDown: false)
            
            spcd?.flags = CGEventFlags.maskCommand;
//            opsd?.flags = CGEventFlags.maskCommand;
            
            let loc = CGEventTapLocation.cghidEventTap
            
            cmdd?.post(tap: loc)
//            opsd?.post(tap: loc)
            spcd?.post(tap: loc)
            
            
            spcu?.post(tap: loc)
//            opsu?.post(tap: loc)
            cmdu?.post(tap: loc)

            self.startLocalNotification()
            print("Clicked")
            
        }
)
       
        
    
        
    }
    
    func startLocalNotification() {
        let notification = NSUserNotification()
     
        notification.title = "通知"
       
        notification.informativeText = "耳机插入，自动播放音乐"
        
        notification.userInfo = ["messageID":1000]
       
        notification.deliveryDate = NSDate(timeIntervalSinceNow: 2) as Date
       
        notification.deliveryRepeatInterval?.minute = 1
        
        NSUserNotificationCenter.default.delegate = self
       
        NSUserNotificationCenter.default.scheduleNotification(notification)
        
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController: NSUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
//        print("didDeliver notification \(notification)")
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        self.view.window?.orderFront(self)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}

