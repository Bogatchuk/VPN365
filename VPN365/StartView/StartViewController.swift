import UIKit
import WebKit
import CoreVPN

class StartViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cancelImputButton: UIButton!
    
    @IBOutlet var viewWithTabs: UIView!
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet weak var undoItem: UIBarButtonItem!
    @IBOutlet weak var redoItem: UIBarButtonItem!
    
    @IBOutlet var tabButtons: [UIButton]!
    private var progressKVOhandle: NSKeyValueObservation?
    
    private var tabList = [
        "Google",
        "Gmail",
        "Yandex",
        "Bing",
        "Apple",
        "YouTube"
    ]
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.navigationDelegate = self
        searchTextField.delegate = self
        cancelImputButton.isHidden = true
        searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        searchTextField.addTarget(self, action: #selector(editingEnded(_:)), for: .editingDidEnd)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if index <= 0 {
            viewWithTabs.isHidden = false
        }else{
            viewWithTabs.isHidden = true
        }
        print(index)
    }
    
    @objc func editingBegan(_ textField: UITextField) {
        cancelImputButton.isHidden = false
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        cancelImputButton.isHidden = false
    }
    
    @objc func editingEnded(_ textField: UITextField) {
        cancelImputButton.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        print(searchTextField.text)
        
        webViewLoad(url: searchTextField.text)
        
        return true
    }
    
    
    @IBAction func cancelImput() {
        cancelImputButton.isHidden = true
        searchTextField.text = ""
        view.endEditing(true)
    }
    
    
    //MARK: fix
    @IBAction func navigateToolBarButtonAction(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            if webView.canGoBack || index > 0  {
                index -= 1
                webView.stopLoading()
                webView.goBack()
                //webView.goBack() {
                webView.goBack()
                
            }else if index <= 0{
                viewWithTabs.isHidden = false
                index = 0
            }
        case 1:
            if webView.canGoForward {
                webView.stopLoading()
                webView.goForward()
                index += 1
                
            }
        default:
            break
        }
        
        if index <= 0 {
            viewWithTabs.isHidden = false
        }else{
            viewWithTabs.isHidden = true
        }
        print(index)
    }
    
    @IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
        webView.reloadFromOrigin()
    }
    
    @IBAction func tabButtonClicked(_ sender: UIButton) {
        viewWithTabs.isHidden = true
        switch sender.tag {
        case 0:
            print("Apple")
            webViewLoad(url: "https://www.apple.com/")
        case 1:
            print("Bing")
            webViewLoad(url: "https://www.bing.com/")
        case 2:
            print("Yandex")
            webViewLoad(url: "https://yandex.ua/")
        case 3:
            print("Gmail")
            webViewLoad(url: "https://www.google.com/intl/ru/gmail/about/")
        case 4:
            print("Google")
            webViewLoad(url: "https://www.google.com/")
        case 5:
            print("YouTube")
            webViewLoad(url: "https://www.youtube.com/")
        default:
            break
        }
    }
    
    func webViewLoad(url: String?){
        
        if let text = url, text.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            if let url = URL(string: text), text.isURL {
                print(url)
                let request = URLRequest(url: url)
                index += 1
                webView.load(request)
                //viewWithTabs.isHidden = true
            }
            else if let keyword = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                print("http://www.google.com/search?q=\(keyword)")
                let url = URL(string: "http://www.google.com/search?q=\(keyword)")!
                let request = URLRequest(url: url)
                index += 1
                webView.load(request)
                //    viewWithTabs.isHidden = true
            }
        }
        
        
        if index <= 0 {
            progressKVOhandle = webView.observe(\.estimatedProgress) { [weak self] (object, _) in
                self?.viewWithTabs.isHidden = self?.webView.estimatedProgress == 1
            }
        }
    }
    
    
    //MARK: - WK Navigation Delegate
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //    adressLabel.text = webView.url?.absoluteString
        searchTextField.text = webView.url?.absoluteString
        
        if webView.canGoBack || index > 0{
            self.undoItem.isEnabled = true
        }else {
            self.undoItem.isEnabled = false
        }
        
        if webView.canGoForward  {
            self.redoItem.isEnabled = true
        } else if !webView.canGoForward && viewWithTabs.isHidden == true{
            self.redoItem.isEnabled = true
        }else {
            self.redoItem.isEnabled = false
        }
        if index <= 0 {
            viewWithTabs.isHidden = false
        }
        print(index)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}


extension String {
    var isURL: Bool {
        if let url = self.stringURL {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    var stringURL: URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }
}
