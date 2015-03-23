import AppKit
import ScriptingBridge

@objc public protocol SBObjectProtocol: NSObjectProtocol {
    func get() -> AnyObject!
}

@objc public protocol SBApplicationProtocol: SBObjectProtocol {
    func activate()
    var delegate: SBApplicationDelegate! { get set }
}

// MARK: SystemPreferencesApplication
@objc public protocol SystemPreferencesApplication: SBApplicationProtocol {
    optional func documents() -> SBElementArray
    optional func windows() -> SBElementArray
    optional var name: String { get } // The name of the application.
    optional var frontmost: Bool { get } // Is this the active application?
    optional var version: String { get } // The version number of the application.
    optional func open(x: AnyObject!) -> AnyObject // Open a document.
    optional func print(x: AnyObject!, withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
    optional func quitSaving(saving: SystemPreferencesSaveOptions) // Quit the application.
    optional func exists(x: AnyObject!) -> Bool // Verify that an object exists.
    optional func panes() -> SBElementArray
    optional var currentPane: SystemPreferencesPane { get set } // the currently selected pane
    optional var preferencesWindow: SystemPreferencesWindow { get } // the main preferences window
    optional var showAll: Bool { get set } // Is SystemPrefs in show all view. (Setting to false will do nothing)
}
extension SBApplication: SystemPreferencesApplication {}

// MARK: SystemPreferencesDocument
@objc public protocol SystemPreferencesDocument: SBObjectProtocol {
    optional var name: String { get } // Its name.
    optional var modified: Bool { get } // Has it been modified since the last save?
    optional var file: NSURL { get } // Its location on disk, if it has one.
    optional func closeSaving(saving: SystemPreferencesSaveOptions, savingIn: NSURL!) // Close a document.
    optional func printWithProperties(withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
}
extension SBObject: SystemPreferencesDocument {}

// MARK: SystemPreferencesWindow
@objc public protocol SystemPreferencesWindow: SBObjectProtocol {
    optional var name: String { get } // The title of the window.
    optional func id() -> Int // The unique identifier of the window.
    optional var index: Int { get set } // The index of the window, ordered front to back.
    optional var bounds: NSRect { get set } // The bounding rectangle of the window.
    optional var closeable: Bool { get } // Does the window have a close button?
    optional var miniaturizable: Bool { get } // Does the window have a minimize button?
    optional var miniaturized: Bool { get set } // Is the window minimized right now?
    optional var resizable: Bool { get } // Can the window be resized?
    optional var visible: Bool { get set } // Is the window visible right now?
    optional var zoomable: Bool { get } // Does the window have a zoom button?
    optional var zoomed: Bool { get set } // Is the window zoomed right now?
    optional var document: SystemPreferencesDocument { get } // The document whose contents are displayed in the window.
    optional func closeSaving(saving: SystemPreferencesSaveOptions, savingIn: NSURL!) // Close a document.
    optional func printWithProperties(withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
}
extension SBObject: SystemPreferencesWindow {}

// MARK: SystemPreferencesPane
@objc public protocol SystemPreferencesPane: SBObjectProtocol {
    optional func anchors() -> SBElementArray
    optional func id() -> String // locale independent name of the preference pane; can refer to a pane using the expression: pane id "<name>"
    optional var localizedName: String { get } // localized name of the preference pane
    optional var name: String { get } // name of the preference pane as it appears in the title bar; can refer to a pane using the expression: pane "<name>"
    optional func closeSaving(saving: SystemPreferencesSaveOptions, savingIn: NSURL!) // Close a document.
    optional func printWithProperties(withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
    optional func reveal() -> AnyObject // Reveals an anchor within a preference pane or preference pane itself
    optional func authorize() -> SystemPreferencesPane // Prompt authorization for given preference pane
}
extension SBObject: SystemPreferencesPane {}

// MARK: SystemPreferencesAnchor
@objc public protocol SystemPreferencesAnchor: SBObjectProtocol {
    optional var name: String { get } // name of the anchor within a preference pane
    optional func closeSaving(saving: SystemPreferencesSaveOptions, savingIn: NSURL!) // Close a document.
    optional func printWithProperties(withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
    optional func reveal() -> AnyObject // Reveals an anchor within a preference pane or preference pane itself
}
extension SBObject: SystemPreferencesAnchor {}
