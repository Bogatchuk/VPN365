import UIKit
import Alamofire
import Firebase

class NetworkService {
    static let shared = NetworkService()
    private var remoteConfig: RemoteConfig!
    
    private init(){}
    
    
    func getIsConfigUrl(closure:@escaping (_ userConfig: UserModel?) -> Void){
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        self.remoteConfig.configSettings = settings
        
        self.remoteConfig.fetchAndActivate { changed, error in
            guard let urlFromFirebase = self.remoteConfig.configValue(forKey: "url").stringValue else { closure(nil)
                return}
            let urlGetConfig = urlFromFirebase
            guard let urlFromServer = URL(string: urlGetConfig) else {
                closure(nil)
                return}
            AF.request(urlFromServer, method: .post).responseDecodable(of: UserModel.self) { (response) in
                switch response.result {
                case .success( _):
                    if let userConfig = response.value {
                        UserConfig.ip = userConfig.ip
                        UserConfig.user_name = userConfig.user_name
                        UserConfig.password = userConfig.password
                        UserConfig.l2tpPSK = userConfig.l2tpPSK

                        UserConfig.vpnProtocol = "l2tp"
                        UserDefaults.standard.setValue("l2tp", forKey: "coreVpnProtocol")
                        UserDefaults.standard.setValue(UserConfig.user_name, forKey: "coreVpnUsername")
                        UserDefaults.standard.setValue(UserConfig.ip, forKey: "coreVpnServer")
                        UserDefaults.standard.setValue(UserConfig.password, forKey: "coreVpnPass")
                        UserDefaults.standard.setValue(UserConfig.l2tpPSK, forKey: "coreVpnPSK")
                        
                        closure(userConfig)
                    }
                    
                case .failure(let error):
                    print(error)
                    closure(nil)
                }
            }
            
        }
    }
    
}

