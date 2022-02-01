import WebKit

extension WKWebView {

enum PrefKey {
    static let cookie = "cookies"
}

func writeDiskCookies(for domain: String, completion: @escaping () -> ()) {
    fetchInMemoryCookies(for: domain) { data in
        UserDefaults.standard.setValue(data, forKey: PrefKey.cookie + domain)
        completion();
    }
}


 func loadDiskCookies(for domain: String, completion: @escaping () -> ()) {
    if let diskCookie = UserDefaults.standard.dictionary(forKey: (PrefKey.cookie + domain)){
        fetchInMemoryCookies(for: domain) { freshCookie in

            let mergedCookie = diskCookie.merging(freshCookie) { (_, new) in new }

            for (_, cookieConfig) in mergedCookie {
                let cookie = cookieConfig as! Dictionary<String, Any>

                var expire : Any? = nil

                if let expireTime = cookie["Expires"] as? Double{
                    expire = Date(timeIntervalSinceNow: expireTime)
                }

                let newCookie = HTTPCookie(properties: [
                    .domain: cookie["Domain"] as Any,
                    .path: cookie["Path"] as Any,
                    .name: cookie["Name"] as Any,
                    .value: cookie["Value"] as Any,
                    .secure: cookie["Secure"] as Any,
                    .expires: expire as Any
                ])

                self.configuration.websiteDataStore.httpCookieStore.setCookie(newCookie!)
            }

            completion()
        }

    }
    else{
        completion()
    }
}

func fetchInMemoryCookies(for domain: String, completion: @escaping ([String: Any]) -> ()) {
    var cookieDict = [String: AnyObject]()
    WKWebsiteDataStore.default().httpCookieStore.getAllCookies { (cookies) in
        for cookie in cookies {
            if cookie.domain.contains(domain) {
                cookieDict[cookie.name] = cookie.properties as AnyObject?
            }
        }
        completion(cookieDict)
    }
}}


