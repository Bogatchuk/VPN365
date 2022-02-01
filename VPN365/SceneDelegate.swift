//
//  SceneDelegate.swift
//  SafariView+vpn
//
//  Created by MPro3.1 on 18.01.2022.
//

import UIKit
import CoreVPN

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var corevpnServers: CoreVPNServerModel?
    var corevpn: CoreVPN?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window: UIWindow? = UIWindow(windowScene: windowScene)
        //window?.rootViewController = WebViewController()
     
            NetworkService.shared.getIsConfigUrl() { userConfig in
                print(userConfig)
                guard let userConfig = userConfig else {
                    self.window?.rootViewController = StartViewController()
                    return
                }
                    print("gjkexbkb rjyabu")
                let corevpnServers = CoreVPNServerModel(ip: UserConfig.ip!, userName: UserConfig.user_name!, password: UserConfig.password!, locationName: nil, locationImageLink: nil, ikev2ID: nil, l2tpPSK: UserConfig.l2tpPSK!, vpnProtocol: UserConfig.vpnProtocol!)


                let corevpn = CoreVPN(serviceName: "CoreVPN Test", servers: [corevpnServers], delegate: self)
                corevpn.connect()
              //  window?.rootViewController = WebViewController()
                VPNConfig.shared.corevpnServers = corevpnServers
                VPNConfig.shared.corevpn = corevpn


            }


        
        window?.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("corevpn!.disconnect() #1")
        VPNConfig.shared.corevpn?.disconnect()
        
    
    }
    
    

    func sceneDidBecomeActive(_ scene: UIScene) {
        VPNConfig.shared.corevpn?.connect()
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {

        VPNConfig.shared.corevpn?.disconnect()
        
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {

        VPNConfig.shared.corevpn?.connect()
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
 
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


extension SceneDelegate: CoreVPNDelegate {
    func serverChanged(server: CoreVPNServerModel) {}
    
    func connenctionTimeChanged(time: String) {}
    
    func connectionStateChanged(state: CoreVPNConnectionState) {
        switch state {
        case .connected:
            print("Connected")
            
            window?.rootViewController = WebViewController()
        case .connecting:
            print("Connecting")
            //window?.rootViewController = LogoViewController()
        case .disconnected:
            print("Disconnected")

            window?.rootViewController = LogoViewController()
            
        case .disconnecting:
            print("Connecting")
        }
    }
    
}
