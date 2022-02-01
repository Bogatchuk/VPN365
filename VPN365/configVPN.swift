import Foundation

 final class UserConfig: Codable {
     private enum SettingsKeys: String{
         case ip
         case userName
         case password
         case ikev2ID
         case vpnProtocol
         case bet_login
         case bet_password
     }
     static var ip: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.ip.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.ip.rawValue
             if let name = newValue {
                 defaults.set(name, forKey: key)
             }
         }
     }
     static var userName: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.userName.rawValue
             if let userName = newValue {
                 defaults.set(userName, forKey: key)
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
             }
         }
     }
     static var ikev2ID: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.ikev2ID.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.ikev2ID.rawValue
             if let ikev2ID = newValue {
                 defaults.set(ikev2ID, forKey: key)
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
             }
         }
     }
     
     static var bet_login: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.bet_login.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.bet_login.rawValue
             if let bet_login = newValue {
                 defaults.set(bet_login, forKey: key)
             }
         }
     }
     
     static var bet_password: String! {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.bet_password.rawValue)
         } set {
             let defaults = UserDefaults.standard
             let key = SettingsKeys.bet_password.rawValue
             if let bet_password = newValue {
                 defaults.set(bet_password, forKey: key)
             }
         }
     }
//    static let userName: String!
//    static let password: String!
//    static let ikev2ID: String!
//    static let vpnProtocol: String!
}
