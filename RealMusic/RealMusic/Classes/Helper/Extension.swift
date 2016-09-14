//
//  Extension.swift
//  EPARK
//
//  Created by Tam Nguyen on 12/4/15.
//  Copyright © 2015 Asian Tech Co. Ltd. All rights reserved.
//

import UIKit
extension UITableView {
    /**
     Registers a UITableViewCell for use in a UITableView.

     - parameter type: The type of cell to register.
     - parameter reuseIdentifier: The reuse identifier for the cell (optional).

     By default, the class name of the cell is used as the reuse identifier.

     Example:
     ```
     class CustomCell: UITableViewCell {}

     let tableView = UITableView()

     // registers the CustomCell class with a reuse identifier of "CustomCell"
     tableView.registerCell(CustomCell)
     ```
     */
    func registerCellClass<T: UITableViewCell>(aClass: T.Type) {
        let identifier = String(aClass)
        registerClass(aClass.self, forCellReuseIdentifier: identifier)
    }

    func registerCellNib<T: UITableViewCell>(aClass: T.Type) {
        let identifier = String(aClass)
        registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewClass<T: UIView>(viewClass: T.Type) {
        let identifier = String(viewClass)
        registerClass(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewNib<T: UIView>(viewClass: T.Type) {
        let identifier = String(viewClass)
        registerNib(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeue<T: UITableViewCell>(aClass: T.Type) -> T! {
        guard let cell = dequeueReusableCellWithIdentifier(String(aClass)) as? T
        else { fatalError(String(aClass) + "isn't registed") }
        return cell
    }

    func dequeue<T: UITableViewHeaderFooterView>(aClass: T.Type) -> T! {
        guard let cell = dequeueReusableHeaderFooterViewWithIdentifier(String(aClass)) as? T
        else { fatalError(String(aClass) + "isn't registed") }
        return cell
    }
}

class Extension: NSObject {

}

extension UINavigationController {
    func popToVC<T: UIViewController>(vcName: T.Type, animated: Bool = false) -> Bool {
        for vc in viewControllers where vc is T {
            popToViewController(vc, animated: animated)
            return true
        }
        return false
    }
}

extension UIViewController {
    static func initialization() -> Self {
        return self.init(nibName: String(self), bundle: nil)
    }
}

extension NSBundle {

    var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }

}

extension UIView {
    enum BorderPostition: Int {
        case Top = 0
        case Left
        case Bottom
        case Right
    }

    func drawWithShadows() {
        // create background image
        let radius = frame.size.height / 2
        let imgSize = (radius * 2) + 1// 1 pixel for stretching
        UIGraphicsBeginImageContext(CGSizeMake(imgSize, imgSize))
        let context = UIGraphicsGetCurrentContext()

        CGContextSetAlpha(context, 0.5)
        CGContextSetLineWidth(context, 0)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor);

        let minx: CGFloat = 0;
        let midx: CGFloat = imgSize / 2
        let maxx: CGFloat = imgSize
        let miny: CGFloat = 0
        let midy: CGFloat = imgSize / 2
        let maxy: CGFloat = imgSize

        CGContextMoveToPoint(context, minx, midy)
        CGContextAddArcToPoint(context, minx, miny, midx, miny, radius)
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius)
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius)
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius)
        CGContextClosePath(context)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)

        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let stretchImage = viewImage.stretchableImageWithLeftCapWidth(Int(radius), topCapHeight: Int(radius))

        let stretch = UIImageView(image: stretchImage)
        stretch.frame = self.bounds
        stretch.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        addSubview(stretch)
        sendSubviewToBack(stretch)
    }

    /**
     Create a corner radius shadow on the UIView

     - parameter cornerRadius: Corner radius value
     - parameter offset:       Shadow's offset
     - parameter opacity:      Shadow's opacity
     - parameter radius:       Shadow's radius
     */
    public func cornerRadiusAndShadow(cornerRadius cornerRadius: CGFloat, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = false
        layer.cornerRadius = cornerRadius
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).CGPath
        layer.masksToBounds = false
    }

    func border(pos: BorderPostition, color: UIColor = UIColor.blackColor(), width: CGFloat = 0.5, insets: UIEdgeInsets = UIEdgeInsetsZero) {
        let rect: CGRect = {
            switch pos {
            case .Top: return CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .Left: return CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .Bottom: return CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .Right: return CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
            }
        }()
        let border = UIView(frame: rect)
        border.tag = pos.rawValue
        border.backgroundColor = color
        border.autoresizingMask = {
            switch pos {
            case .Top: return [.FlexibleWidth, .FlexibleBottomMargin]
            case .Left: return [.FlexibleHeight, .FlexibleRightMargin]
            case .Bottom: return [.FlexibleWidth, .FlexibleTopMargin]
            case .Right: return [.FlexibleHeight, .FlexibleLeftMargin]
            }
        }()
        addSubview(border)
    }
    var x: CGFloat {
        set { frame = CGRect(x: newValue, y: y, width: width, height: height) }
        get { return frame.origin.x }
    }

    var y: CGFloat {
        set { frame = CGRect(x: x, y: newValue, width: width, height: height) }
        get { return frame.origin.y }
    }

    var width: CGFloat {
        set { frame = CGRect(x: x, y: y, width: newValue, height: height) }
        get { return bounds.width }
    }

    var height: CGFloat {
        set { frame = CGRect(x: x, y: y, width: width, height: newValue) }
        get { return bounds.height }
    }

    convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
}

extension UIImage {

    func optimizedImageFromImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let optimizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return optimizedImage
    }

}

extension UIColor {
    public convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }

    public convenience init?(hexString: String, alpha: Float) {
        var hex = hexString

        // Check for hash and remove the hash
        if hex.hasPrefix("#") {
            hex = hex.substringFromIndex(hex.startIndex.advancedBy(1))
        }

        if (hex.rangeOfString("(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .RegularExpressionSearch) != nil) {

            // Deal with 3 character Hex strings
            if hex.characters.count == 3 {
                let redHex = hex.substringToIndex(hex.startIndex.advancedBy(1))
                let greenHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(1)..<hex.startIndex.advancedBy(2)))
                let blueHex = hex.substringFromIndex(hex.startIndex.advancedBy(2))

                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }

            let redHex = hex.substringToIndex(hex.startIndex.advancedBy(2))
            let greenHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(2)..<hex.startIndex.advancedBy(4)))
            let blueHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(4)..<hex.startIndex.advancedBy(6)))

            var redInt: CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt: CUnsignedInt = 0

            NSScanner(string: redHex).scanHexInt(&redInt)
            NSScanner(string: greenHex).scanHexInt(&greenInt)
            NSScanner(string: blueHex).scanHexInt(&blueInt)

            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        }
        else {
            // Note:
            // The swift 1.1 compiler is currently unable to destroy partially initialized classes in all cases,
            // so it disallows formation of a situation where it would have to.  We consider this a bug to be fixed
            // in future releases, not a feature. -- Apple Forum
            self.init()
            return nil
        }
    }

    public convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }

    public convenience init?(hex: Int, alpha: Float) {
        let hexString = NSString(format: "%2X", hex)
        self.init(hexString: hexString as String, alpha: alpha)
    }
}

extension NSData {
    var hexString: String {
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count: self.length)
        return bytes.map { String(format: "%02hhx", $0) }.reduce("", combine: { $0 + $1 })
    }
}

extension NSDate {
    func stringFormatDateAgo() -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd \'at\' HH:mm"
        dateFormat.formatterBehavior = NSDateFormatterBehavior.Behavior10_4
        let today = NSDate()
        var timeInterval = today.timeIntervalSinceDate(self)
        timeInterval -= 1
        if timeInterval < 1 {
            return "just now"
        }

        if timeInterval < 60 {
            return "less than a minute ago"
        }

        if timeInterval < 3600 {
            let diff = Int(round(timeInterval / 60))
            return "\(diff) minutes ago"
        }

        if timeInterval < 86400 {
            let diff = Int(round(timeInterval / 60 / 60))
            return "\(diff) hours ago"
        }

        if timeInterval < 864000 {
            let diff = Int(round(timeInterval / 60 / 60 / 24))
            return "\(diff) days ago"
        }
        return dateFormat.stringFromDate(self)
    }

}
extension NSDictionary {
    func integerForKey(key: String) -> NSInteger {
        if let value = self.valueForKey(key) as? NSInteger {
            return value
        }
        return 0
    }

    func stringForKey(key: String) -> String {
        if let value = self.valueForKey(key) as? String {
            return value
        }
        return ""
    }

    func arrayForKey(key: String) -> NSArray {
        if let value = self.valueForKey(key) as? NSArray {
            return value
        }
        return NSArray()
    }

    func boolForKey(key: String) -> Bool {
        if let value = self.valueForKey(key) as? Bool {
            return value
        }
        return false
    }

    func doubleForKey(key: String) -> Double {
        if let value = self.valueForKey(key) as? Double {
            return value
        }
        return 0.0
    }

    func dictionaryForKey(key: String) -> NSDictionary {
        if let value = self.objectForKey(key) as? NSDictionary {
            return value
        }
        return NSDictionary()
    }
}

extension String {
    var length: Int {
        return self.characters.count
    }

    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }

    func trimNewLine() -> String {
        var text = self
        while text.characters.last == Character("\n") || text.characters.last == Character(" ") {
            text = text.substringToIndex(text.endIndex.advancedBy(-1))
        }
        while text.characters.first == Character("\n") || text.characters.first == Character(" ") {
            text = text.substringFromIndex(text.startIndex.advancedBy(1))
        }
        return text
    }

    func removeTagHTML() -> String {
        var clearString = self.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&amp;", withString: "&", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&gt;", withString: ">", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&lt;", withString: "<", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&quot;", withString: "\"", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&#39;", withString: "'", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&apos;", withString: "'", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        clearString = clearString.stringByReplacingOccurrencesOfString("&nbsp;", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        return clearString
    }

}

extension UITextView: UITextViewDelegate {

    // Placeholder text
    var placeholder: String? {

        get {
            // Get the placeholder text from the label
            var placeholderText: String?

            if let placeHolderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeHolderLabel.text
            }
            return placeholderText
        }

        set {
            // Store the placeholder text in the label
            let placeHolderLabel = self.viewWithTag(100) as! UILabel?
            if placeHolderLabel == nil {
                // Add placeholder label to text view
                self.addPlaceholderLabel(newValue!)
            }
            else {
                placeHolderLabel?.text = newValue
//                placeHolderLabel?.sizeToFit()
            }
        }
    }

    // Hide the placeholder label if there is no text
    // in the text viewotherwise, show the label
    public func textViewDidChange(textView: UITextView) {

        let placeHolderLabel = self.viewWithTag(100)

        if !self.hasText() {
            // Get the placeholder label
            placeHolderLabel?.hidden = false
        }
        else {
            placeHolderLabel?.hidden = true
        }
    }

    // Add a placeholder label to the text view
    func addPlaceholderLabel(placeholderText: String) {

        // Create the label and set its properties
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin.x = 5.0
        placeholderLabel.frame.origin.y = 5.0
        if ScreenSize.SCREEN_WIDTH == 320 {
            placeholderLabel.font = UIFont(name: "Hiragino Kaku Gothic ProN", size: 10)
        } else {
            placeholderLabel.font = UIFont(name: "Hiragino Kaku Gothic ProN", size: 13)
        }

        placeholderLabel.textColor = UIColor.lightGrayColor()
//        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 100

        // Hide the label if there is text in the text view
        placeholderLabel.hidden = self.text.characters.count > 0

        self.addSubview(placeholderLabel)
        self.delegate = self;
    }

}

extension NSDate
{
    func hour() -> Int
    {
        // Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour

        // Return Hour
        return hour

    }

    func year() -> Int
    {
        // Get Year
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self)
        let year = components.year

        // Return Year
        return year
    }

    func month() -> Int
    {
        // Get Month
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month

        // Return month
        return month

    }

    func day() -> Int
    {
        // Get Day
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day

        // Return Day
        return day

    }

    func minute() -> Int
    {
        // Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute

        // Return Minute
        return minute
    }

    func second() -> Int
    {
        // Get Second
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Second, fromDate: self)
        let second = components.second

        // Return Second
        return second
    }

    func toShortTimeString() -> String
    {
        // Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)

        // Return Short Time String
        return timeString
    }

    func dayOfWeek() -> Int! {
        if
        let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) {
                return comp.weekday
        } else {
                return nil
        }
    }
}
