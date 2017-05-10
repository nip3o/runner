import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    var delegate: PreferencesWindowDelegate?
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var commandTextField: NSTextField!
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        let defaults = UserDefaults.standard
        nameTextField.stringValue = defaults.string(forKey: "name") ?? ""
        commandTextField.stringValue = defaults.string(forKey: "command") ?? ""
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(nameTextField.stringValue, forKey: "name")
        defaults.setValue(commandTextField.stringValue, forKey: "command")
        
        delegate?.preferencesDidUpdate()
    }
}
