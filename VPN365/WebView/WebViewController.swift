import UIKit
import WebKit
import WKCookieWebView
import CoreVPN



class WebViewController: UIViewController, WKUIDelegate {
 
    @IBOutlet weak var webView: WKCookieWebView!


    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(webView)
        let urlString = "http://www.bet365.ru/#/HO/"
    
        let isNeedPreloadForCookieSync = false
        let cookie = HTTPCookie(properties: [
            .domain: "bet365.ru",
            .path: "/",
            .name: "[Test] Cookie",
            .value: "value!!"])!
        
        HTTPCookieStorage.shared.setCookie(cookie)
//        if isNeedPreloadForCookieSync {
//            WKCookieWebView.preloadWithDomainForCookieSync(urlString: urlString) { [weak self] in
//                self?.webView.load(URLRequest(url: URL(string: urlString)!))
//            }
//        } else {
//            webView.load(URLRequest(url: URL(string: urlString)!))
//        }

        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: urlString)!))
        
       
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.view.addSubview(webView)
    }
    
  
        
        @objc private func printCookie() {
            guard let url = webView.url else {
                return
            }

            HTTPCookieStorage.shared.cookies(for: url)?.forEach {
                print($0)
            }
        }

}
   

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
 
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)

    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
    
}


extension WebViewController: CoreVPNDelegate {
    func serverChanged(server: CoreVPNServerModel) {}
    
    func connenctionTimeChanged(time: String) {}
    
    func connectionStateChanged(state: CoreVPNConnectionState) {
        switch state {
        case .connected:
            print("Connectedsfgfdsg")
            
        case .connecting:
            print("Connecting")
            //window?.rootViewController = LogoViewController()
        case .disconnected:
            print("Disconnecteddsfgdsfg")
            //window?.rootViewController = LogoViewController()
            
        case .disconnecting:
            print("Connecting")
        }
    }
    
}
