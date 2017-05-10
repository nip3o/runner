import Cocoa

class StatusMenuController: NSObject, PreferencesWindowDelegate {    
    @IBOutlet weak var statusMenu: NSMenu!
    
    var preferencesWindow: PreferencesWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    func noop() {}
    
    func updateMenu() {
        let defaults = UserDefaults.standard
        
        if let name = defaults.string(forKey: "name") {
            if statusMenu.items.count > 3 {
                statusMenu.removeItem(at: 1)
                statusMenu.removeItem(at: 0)
            }
            let runDate = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            
            let titleItem = NSMenuItem(title: name, action: #selector(StatusMenuController.noop), keyEquivalent: "")
            let taskStatusItem = NSMenuItem(title: "  Last run at \(formatter.string(from: runDate))", action: #selector(StatusMenuController.noop), keyEquivalent: "")
            
            statusMenu.insertItem(titleItem, at: 0)
            statusMenu.insertItem(taskStatusItem, at: 1)
        }
    }
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu

        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
        updateMenu()
    }
    
    func preferencesDidUpdate() {
        updateMenu()
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
}
