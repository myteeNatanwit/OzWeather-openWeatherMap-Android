// this is to demo the way to call aboutbox component.
//1- aboutbox itself acts as a blackbox.
//2-parent calls it - so the way it called is from parent side.

import UIKit

class AboutViewController: UIViewController {
    @IBAction func btnClk(_ sender: Any) {
        dismiss(animated: true) {} // should not self dismiss here, but only aboutbox ismeant to return nothing.
        navigationController?.popViewController(animated: true);
    }
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var build: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = getAppIcon(); // show app icon
        if let _appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            appName.text = _appName
//debug            print("App Name - \(_appName)")
        }
        if let _version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.version.text = "Version: " + _version
        }
        if let _build =  Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            build.text = "Build: " + _build;
        }
//debug        print("Bundle.main.infoDictionary - \(Bundle.main.infoDictionary)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getAppIcon() -> UIImage {
        let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary
        let primaryIconsDictionary = iconsDictionary?["CFBundlePrimaryIcon"] as? NSDictionary
        let iconFiles = primaryIconsDictionary!["CFBundleIconFiles"] as! NSArray
        let lastIcon = iconFiles.lastObject as! NSString
        let icon = UIImage(named: lastIcon as String)
        return icon!
    }
}

