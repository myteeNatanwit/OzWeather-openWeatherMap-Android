
import Foundation
import UIKit



/** Name: localStorageWrite
 for:  store data to local storage
 param:
 return:
 Note:
 Usage:
 */
func localStorageWrite(myKey: String, value: String) {
    let localStorage = UserDefaults.standard;
    localStorage.set(value, forKey : myKey);
}
/** Name: localStorageRead
 for: Get data from local storage
 param:
 return:
 Note:
 Usage:
 */

func localStorageRead(key: String) -> String{
    let localStorage = UserDefaults.standard;
    if let value: String = localStorage.object(forKey: key) as? String{
        return value;
    }
    return "";
}

/** Name: callNumber
 for:
 param:
 return:
 Note:
 Usage:
 */

func callNumber(phoneNumber:String) {
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            if #available(iOS 10.0, *) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

func userAlreadyExist(kUsernameKey: String) -> Bool {
    return UserDefaults.standard.object(forKey: kUsernameKey) != nil
}

func alert (title: String, message: String) {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    alertController.addAction(alertAction)
    appDelegate.window!.rootViewController?.present(alertController, animated: true, completion: nil)
    
}

func msgBox (mytitle: String, mymessage: String, callback:  @escaping () -> ()) {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
    let refreshAlert = UIAlertController(title: mytitle, message: mymessage, preferredStyle: UIAlertControllerStyle.alert)
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        callback()
    }))
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        print("cancelled")
    }))
    appDelegate.window!.rootViewController?.present(refreshAlert, animated: true, completion: nil)
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
// usage: var color1 = hexStringToUIColor("#d3d3d3")
func hexStringToUIColor (hex: String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UIView{
    func showBlurLoader(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.addSubview(blurEffectView)
    }
    
    func removeBluerLoader(){
        self.subviews.flatMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
}

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
// imageView.downloadedFrom(link: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
extension UIImageView {
    func downloadedFrom(url: String) {
        let url = URL(string: url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}
// LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)
public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var bgView = UIView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView) {
        
        bgView.frame = view.frame
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        bgView.addSubview(overlayView)
        bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.center = view.center
        overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(bgView)
        self.activityIndicator.startAnimating()
        
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        bgView.removeFromSuperview()
    }
}

/*
 name: getUserData
 purpose: go a get or post query to the theURL var
 param:url
 output: data in callback
 usage: getUserdata (url){text in ... }
 */
func getUserData( _ url: String, callback:  @escaping (_ result: Weather) -> ()) {
    let myUrl = URL(string: url);
    var request = URLRequest(url: myUrl!)
    let session = URLSession.shared;
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
   
    DispatchQueue.global().async { // run in background
        
    let task = session.dataTask(with: request) { data, response, error in
        guard let result = data, error == nil else
        {
            print("\(error?.localizedDescription ?? "Unknown error")")
            return
        }
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response)")
            
        }
        let responseString = String(data: result, encoding: .utf8)
        guard let data = data else {
            print("Error: No data to decode")
            return
        }
        
        guard let weatherData = try? JSONDecoder().decode(Weather.self, from: data) else {
            print("Error: Couldn't decode data into array")
            return
        }
        
        // change UI only it sync
        DispatchQueue.main.async() {
            callback(weatherData) // run in foreground
        }
        
    }
        task.resume() }
}

