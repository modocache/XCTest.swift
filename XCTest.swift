
var XCT_GENERICS_AVAILABLE: Int32 { get }
var XCT_NULLABLE_AVAILABLE: Int32 { get }
var XCT_UI_TESTING_AVAILABLE: Int32 { get }
let XCTestErrorDomain: String
enum XCTestErrorCode : Int {
  init?(rawValue rawValue: Int)
  var rawValue: Int { get }
  case timeoutWhileWaiting
  case failureWhileWaiting
}
class XCTest : NSObject {
  var testCaseCount: UInt { get }
  var name: String? { get }
  var testRunClass: AnyClass? { get }
  var testRun: XCTestRun? { get }
  func perform(_ run: XCTestRun)
  @available(*, deprecated)
  func run() -> XCTestRun
  func run()
  func setUp()
  func tearDown()
}
class XCTestCase : XCTest {
  init(invocation invocation: NSInvocation?)
  init(selector selector: Selector)
  var invocation: NSInvocation?
  func invokeTest()
  var continueAfterFailure: Bool
  func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: UInt, expected expected: Bool)
  class func testInvocations() -> [NSInvocation]
  class func defaultPerformanceMetrics() -> [String]
  func measure(_ block: () -> Void)
  func measureMetrics(_ metrics: [String], automaticallyStartMeasuring automaticallyStartMeasuring: Bool, for block: () -> Void)
  func startMeasuring()
  func stopMeasuring()
  func addUIInterruptionMonitor(withDescription handlerDescription: String, handler handler: (XCUIElement) -> Bool) -> NSObjectProtocol
  func removeUIInterruptionMonitor(_ monitor: NSObjectProtocol)
}
let XCTPerformanceMetric_WallClockTime: String
extension XCTestCase {
  class func defaultTestSuite() -> XCTestSuite
  class func setUp()
  class func tearDown()
}
class _XCTestCaseInterruptionException : NSException {
}
func _XCTPreformattedFailureHandler(_ test: XCTestCase, _ expected: Bool, _ filePath: String, _ lineNumber: UInt, _ condition: String, _ message: String)
enum _XCTAssertionType : UInt {
  init?(rawValue rawValue: UInt)
  var rawValue: UInt { get }
  case fail
  case `nil`
  case notNil
  case equalObjects
  case notEqualObjects
  case equal
  case notEqual
  case equalWithAccuracy
  case notEqualWithAccuracy
  case greaterThan
  case greaterThanOrEqual
  case lessThan
  case lessThanOrEqual
  case `true`
  case `false`
  case `throws`
  case throwsSpecific
  case throwsSpecificNamed
  case noThrow
  case noThrowSpecific
  case noThrowSpecificNamed
}
func _XCTFailureFormat(_ assertionType: _XCTAssertionType, _ formatIndex: UInt) -> String
func _XCTDescriptionForValue(_ value: NSValue) -> String
class XCTestExpectation : NSObject {
  func fulfill()
}
extension XCTestCase {
  func expectation(withDescription description: String) -> XCTestExpectation
  func waitForExpectations(withTimeout timeout: NSTimeInterval, handler handler: XCWaitCompletionHandler? = nil)
  func keyValueObservingExpectation(for objectToObserve: AnyObject, keyPath keyPath: String, expectedValue expectedValue: AnyObject?) -> XCTestExpectation
  func keyValueObservingExpectation(for objectToObserve: AnyObject, keyPath keyPath: String, handler handler: XCKeyValueObservingExpectationHandler? = nil) -> XCTestExpectation
  func expectation(forNotification notificationName: String, object objectToObserve: AnyObject?, handler handler: XCNotificationExpectationHandler? = nil) -> XCTestExpectation
  func expectation(for predicate: NSPredicate, evaluatedWith object: AnyObject, handler handler: XCPredicateExpectationHandler? = nil) -> XCTestExpectation
}
typealias XCWaitCompletionHandler = (NSError?) -> Void
typealias XCKeyValueObservingExpectationHandler = (AnyObject, [NSObject : AnyObject]) -> Bool
typealias XCNotificationExpectationHandler = (NSNotification) -> Bool
typealias XCPredicateExpectationHandler = () -> Bool
class XCTestRun : NSObject {
  init(test test: XCTest)
  var test: XCTest { get }
  func start()
  func stop()
  @NSCopying var startDate: NSDate? { get }
  @NSCopying var stopDate: NSDate? { get }
  var totalDuration: NSTimeInterval { get }
  var testDuration: NSTimeInterval { get }
  var testCaseCount: UInt { get }
  var executionCount: UInt { get }
  var failureCount: UInt { get }
  var unexpectedExceptionCount: UInt { get }
  var totalFailureCount: UInt { get }
  var hasSucceeded: Bool { get }
  func recordFailure(withDescription description: String, inFile filePath: String?, atLine lineNumber: UInt, expected expected: Bool)
}
class XCTestCaseRun : XCTestRun {
  @available(*, deprecated)
  func recordFailure(inTest testCase: XCTestCase, withDescription description: String, inFile filePath: String, atLine lineNumber: UInt, expected expected: Bool)
}
@available(*, deprecated)
class XCTestObserver : NSObject {
  func startObserving()
  func stopObserving()
  func testSuiteDidStart(_ testRun: XCTestRun!)
  func testSuiteDidStop(_ testRun: XCTestRun!)
  func testCaseDidStart(_ testRun: XCTestRun!)
  func testCaseDidStop(_ testRun: XCTestRun!)
  func testCaseDidFail(_ testRun: XCTestRun!, withDescription description: String!, inFile filePath: String!, atLine lineNumber: UInt)
}
@available(*, deprecated)
let XCTestObserverClassKey: String
@available(*, deprecated)
class XCTestLog : XCTestObserver {
  var logFileHandle: NSFileHandle! { get }
  func testLog(withFormat format: String!, arguments arguments: CVaListPointer)
}
protocol XCTestObservation : NSObjectProtocol {
  optional func testBundleWillStart(_ testBundle: NSBundle)
  optional func testBundleDidFinish(_ testBundle: NSBundle)
  optional func testSuiteWillStart(_ testSuite: XCTestSuite)
  optional func testSuite(_ testSuite: XCTestSuite, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt)
  optional func testSuiteDidFinish(_ testSuite: XCTestSuite)
  optional func testCaseWillStart(_ testCase: XCTestCase)
  optional func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt)
  optional func testCaseDidFinish(_ testCase: XCTestCase)
}
class XCTestObservationCenter : NSObject {
  class func shared() -> XCTestObservationCenter
  func addTestObserver(_ testObserver: XCTestObservation)
  func removeTestObserver(_ testObserver: XCTestObservation)
}
@available(*, deprecated)
func XCTSelfTestMain() -> Int32
@available(*, deprecated)
class XCTestProbe : NSObject {
  class func isTesting() -> Bool
}
@available(*, deprecated)
let XCTestedUnitPath: String
@available(*, deprecated)
let XCTestScopeKey: String
@available(*, deprecated)
let XCTestScopeAll: String
@available(*, deprecated)
let XCTestScopeNone: String
@available(*, deprecated)
let XCTestScopeSelf: String
@available(*, deprecated)
let XCTestToolKey: String
class XCTestSuite : XCTest {
  class func defaultTestSuite() -> Self
  convenience init(forBundlePath bundlePath: String)
  convenience init(forTestCaseWithName name: String)
  convenience init(forTestCaseClass testCaseClass: AnyClass)
  init(name name: String)
  func addTest(_ test: XCTest)
  var tests: [XCTest] { get }
}
class XCTestSuiteRun : XCTestRun {
  var testRuns: [XCTestRun] { get }
  func addTest(_ testRun: XCTestRun)
}
@available(OSX 10.11, *)
enum XCUIElementType : UInt {
  init?(rawValue rawValue: UInt)
  var rawValue: UInt { get }
  case any
  case other
  case application
  case group
  case window
  case sheet
  case drawer
  case alert
  case dialog
  case button
  case radioButton
  case radioGroup
  case checkBox
  case disclosureTriangle
  case popUpButton
  case comboBox
  case menuButton
  case toolbarButton
  case popover
  case keyboard
  case key
  case navigationBar
  case tabBar
  case tabGroup
  case toolbar
  case statusBar
  case table
  case tableRow
  case tableColumn
  case outline
  case outlineRow
  case browser
  case collectionView
  case slider
  case pageIndicator
  case progressIndicator
  case activityIndicator
  case segmentedControl
  case picker
  case pickerWheel
  case `switch`
  case toggle
  case link
  case image
  case icon
  case searchField
  case scrollView
  case scrollBar
  case staticText
  case textField
  case secureTextField
  case datePicker
  case textView
  case menu
  case menuItem
  case menuBar
  case menuBarItem
  case map
  case webView
  case incrementArrow
  case decrementArrow
  case timeline
  case ratingIndicator
  case valueIndicator
  case splitGroup
  case splitter
  case relevanceIndicator
  case colorWell
  case helpTag
  case matte
  case dockItem
  case ruler
  case rulerMarker
  case grid
  case levelIndicator
  case cell
  case layoutArea
  case layoutItem
  case handle
  case stepper
  case tab
}
enum XCUIUserInterfaceSizeClass : Int {
  init?(rawValue rawValue: Int)
  var rawValue: Int { get }
  case unspecified
}
protocol XCUIElementAttributes {
  var identifier: String { get }
  var frame: CGRect { get }
  var value: AnyObject? { get }
  var title: String { get }
  var label: String { get }
  @available(OSX 10.11, *)
  var elementType: XCUIElementType { get }
  var isEnabled: Bool { get }
  var horizontalSizeClass: XCUIUserInterfaceSizeClass { get }
  var verticalSizeClass: XCUIUserInterfaceSizeClass { get }
  var placeholderValue: String? { get }
  var isSelected: Bool { get }
}
protocol XCUIElementTypeQueryProvider {
  @available(OSX 10.11, *)
  @NSCopying var groups: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var windows: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var sheets: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var drawers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var alerts: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var dialogs: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var buttons: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var radioButtons: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var radioGroups: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var checkBoxes: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var disclosureTriangles: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var popUpButtons: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var comboBoxes: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var menuButtons: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var toolbarButtons: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var popovers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var keyboards: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var keys: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var navigationBars: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var tabBars: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var tabGroups: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var toolbars: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var statusBars: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var tables: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var tableRows: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var tableColumns: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var outlines: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var outlineRows: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var browsers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var collectionViews: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var sliders: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var pageIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var progressIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var activityIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var segmentedControls: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var pickers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var pickerWheels: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var switches: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var toggles: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var links: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var images: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var icons: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var searchFields: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var scrollViews: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var scrollBars: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var staticTexts: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var textFields: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var secureTextFields: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var datePickers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var textViews: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var menus: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var menuItems: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var menuBars: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var menuBarItems: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var maps: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var webViews: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var steppers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var incrementArrows: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var decrementArrows: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var tabs: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var timelines: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var ratingIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var valueIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var splitGroups: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var splitters: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var relevanceIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var colorWells: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var helpTags: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var mattes: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var dockItems: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var rulers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var rulerMarkers: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var grids: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var levelIndicators: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var cells: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var layoutAreas: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var layoutItems: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var handles: XCUIElementQuery { get }
  @available(OSX 10.11, *)
  @NSCopying var otherElements: XCUIElementQuery { get }
}
@available(OSX 10.11, *)
struct XCUIKeyModifierFlags : OptionSet {
  init(rawValue rawValue: UInt)
  let rawValue: UInt
  static var alphaShift: XCUIKeyModifierFlags { get }
  static var shift: XCUIKeyModifierFlags { get }
  static var control: XCUIKeyModifierFlags { get }
  static var alternate: XCUIKeyModifierFlags { get }
  static var option: XCUIKeyModifierFlags { get }
  static var command: XCUIKeyModifierFlags { get }
}
@available(OSX 10.11, *)
class XCUIElement : NSObject, XCUIElementAttributes, XCUIElementTypeQueryProvider {
  var exists: Bool { get }
  var isHittable: Bool { get }
  func descendants(matching type: XCUIElementType) -> XCUIElementQuery
  func children(matching type: XCUIElementType) -> XCUIElementQuery
  func coordinate(withNormalizedOffset normalizedOffset: CGVector) -> XCUICoordinate
}
extension XCUIElement {
  func typeText(_ text: String)
  func hover()
  func click()
  func doubleClick()
  func rightClick()
  func click(forDuration duration: NSTimeInterval, thenDragTo otherElement: XCUIElement)
  class func perform(withKeyModifiers flags: XCUIKeyModifierFlags, block block: () -> Void)
  func typeKey(_ key: String, modifierFlags flags: XCUIKeyModifierFlags)
  func scroll(byDeltaX deltaX: CGFloat, deltaY deltaY: CGFloat)
}
extension XCUIElement {
  func adjust(toNormalizedSliderPosition normalizedSliderPosition: CGFloat)
  var normalizedSliderPosition: CGFloat { get }
}
@available(OSX 10.11, *)
class XCUIApplication : XCUIElement {
  func launch()
  func terminate()
  var launchArguments: [String]
  var launchEnvironment: [String : String]
}
@available(OSX 10.11, *)
class XCUICoordinate : NSObject, NSCopying {
  var referencedElement: XCUIElement { get }
  var screenPoint: CGPoint { get }
  func withOffset(_ offsetVector: CGVector) -> XCUICoordinate
  func hover()
  func click()
  func doubleClick()
  func rightClick()
  func click(forDuration duration: NSTimeInterval, thenDragTo otherCoordinate: XCUICoordinate)
  func scroll(byDeltaX deltaX: CGFloat, deltaY deltaY: CGFloat)
}
let XCUIIdentifierCloseWindow: String
let XCUIIdentifierMinimizeWindow: String
let XCUIIdentifierZoomWindow: String
let XCUIIdentifierFullScreenWindow: String
@available(OSX 10.11, *)
class XCUIElementQuery : NSObject, XCUIElementTypeQueryProvider {
  var element: XCUIElement { get }
  var count: UInt { get }
  @available(OSX, introduced: 10.11, deprecated: 10.11, message: "Use elementBoundByIndex instead.")
  func element(at index: UInt) -> XCUIElement
  func elementBound(by index: UInt) -> XCUIElement
  func element(matching predicate: NSPredicate) -> XCUIElement
  func element(matching elementType: XCUIElementType, identifier identifier: String?) -> XCUIElement
  subscript(_ key: String) -> XCUIElement { get }
  var allElementsBoundByAccessibilityElement: [XCUIElement] { get }
  var allElementsBoundByIndex: [XCUIElement] { get }
  func descendants(matching type: XCUIElementType) -> XCUIElementQuery
  func children(matching type: XCUIElementType) -> XCUIElementQuery
  func matchingPredicate(_ predicate: NSPredicate) -> XCUIElementQuery
  func matchingType(_ elementType: XCUIElementType, identifier identifier: String?) -> XCUIElementQuery
  func matchingIdentifier(_ identifier: String) -> XCUIElementQuery
  func containing(_ predicate: NSPredicate) -> XCUIElementQuery
  func containing(_ elementType: XCUIElementType, identifier identifier: String?) -> XCUIElementQuery
}
let XCUIKeyboardKeyDelete: String
let XCUIKeyboardKeyReturn: String
let XCUIKeyboardKeyEnter: String
let XCUIKeyboardKeyTab: String
let XCUIKeyboardKeySpace: String
let XCUIKeyboardKeyEscape: String
let XCUIKeyboardKeyUpArrow: String
let XCUIKeyboardKeyDownArrow: String
let XCUIKeyboardKeyLeftArrow: String
let XCUIKeyboardKeyRightArrow: String
let XCUIKeyboardKeyF1: String
let XCUIKeyboardKeyF2: String
let XCUIKeyboardKeyF3: String
let XCUIKeyboardKeyF4: String
let XCUIKeyboardKeyF5: String
let XCUIKeyboardKeyF6: String
let XCUIKeyboardKeyF7: String
let XCUIKeyboardKeyF8: String
let XCUIKeyboardKeyF9: String
let XCUIKeyboardKeyF10: String
let XCUIKeyboardKeyF11: String
let XCUIKeyboardKeyF12: String
let XCUIKeyboardKeyF13: String
let XCUIKeyboardKeyF14: String
let XCUIKeyboardKeyF15: String
let XCUIKeyboardKeyF16: String
let XCUIKeyboardKeyF17: String
let XCUIKeyboardKeyF18: String
let XCUIKeyboardKeyF19: String
let XCUIKeyboardKeyForwardDelete: String
let XCUIKeyboardKeyHome: String
let XCUIKeyboardKeyEnd: String
let XCUIKeyboardKeyPageUp: String
let XCUIKeyboardKeyPageDown: String
let XCUIKeyboardKeyClear: String
let XCUIKeyboardKeyHelp: String
let XCUIKeyboardKeyCapsLock: String
let XCUIKeyboardKeyShift: String
let XCUIKeyboardKeyControl: String
let XCUIKeyboardKeyOption: String
let XCUIKeyboardKeyCommand: String
let XCUIKeyboardKeyRightShift: String
let XCUIKeyboardKeyRightControl: String
let XCUIKeyboardKeyRightOption: String
let XCUIKeyboardKeyRightCommand: String
let XCUIKeyboardKeySecondaryFn: String
enum XCUIRemoteButton : UInt {
  init?(rawValue rawValue: UInt)
  var rawValue: UInt { get }
  case up
  case down
  case left
  case right
  case select
  case menu
  case playPause
}
