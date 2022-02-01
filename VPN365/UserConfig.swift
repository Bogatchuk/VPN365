import Foundation


 final class UserConfig: Codable {
     private enum SettingsKeys: String{
         case ip
         case user_name
         case password
         case l2tpPSK
         case vpnProtocol
     }
     
     
     static var user_name: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.user_name.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.user_name.rawValue
             if let user_name = newValue {
                 defaults.set(user_name, forKey: key)
             }else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
     
     static var ip: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.ip.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.ip.rawValue
             if let name = newValue {
                 defaults.set(name, forKey: key)
             }else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
     static var password: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.password.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.password.rawValue
             if let password = newValue {
                 defaults.set(password, forKey: key)
             }else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
     static var l2tpPSK: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.l2tpPSK.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.l2tpPSK.rawValue
             if let l2tpPSK = newValue {
                 defaults.set(l2tpPSK, forKey: key)
             }else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
     
     static var vpnProtocol: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.vpnProtocol.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.vpnProtocol.rawValue
             if let vpnProtocol = newValue {
                 defaults.set(vpnProtocol, forKey: key)
             }else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
     
}

