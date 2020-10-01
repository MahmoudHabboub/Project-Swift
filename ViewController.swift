//
//  ViewController.swift
//  MyProject
//
//  Created by محمود محمد on 12/8/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 @IBOutlet weak var On_Boarding: UIView!
 @IBOutlet weak var Main_View: UIView!
 @IBOutlet weak var CircleView_1: UIView!
 @IBOutlet weak var CircleView_2: UIView!
 @IBOutlet weak var CircleView_3: UIView!
 @IBOutlet var Button: UIButton!
 @IBOutlet weak var Label_91: UILabel!
 @IBOutlet weak var TextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let Color_One = UIColor(hexString:"#5927FF")!
        let Color_Two = UIColor(hexString: "#8160EF")!
        On_Boarding.applyGradient(colours: [Color_Two, Color_One])
        Main_View.applyGradient(colours: [Color_Two, Color_One])
        
        //1
        CircleView_1.layer.cornerRadius = CircleView_1.frame.size.width/2
        CircleView_1.clipsToBounds = true
        CircleView_1.layer.borderColor = UIColor.init(hexString:"#44E4A5")?.cgColor
        CircleView_1.layer.borderWidth = 5.0
        
        //2
        CircleView_2.layer.cornerRadius = CircleView_2.frame.size.width/2
        CircleView_2.clipsToBounds = true
        CircleView_2.layer.borderColor = UIColor.init(hexString:"#44E4A5")?.cgColor
        CircleView_2.layer.borderWidth = 5.0
        
        //3
        CircleView_3.layer.cornerRadius = CircleView_3.frame.size.width/2
        CircleView_3.clipsToBounds = true
        CircleView_3.layer.borderColor = UIColor.init(hexString:"#44E4A5")?.cgColor
        CircleView_3.layer.borderWidth = 5.0
        
        //
        Button.setImage(UIImage(named: "OnBoardingButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //
        let maskPath = UIBezierPath(roundedRect: Label_91.bounds,
                                    byRoundingCorners: [.bottomLeft, .topLeft],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        Label_91.layer.mask = shape
        
        //
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        TextField.leftView = paddingView
        TextField.leftViewMode = .always
        
        
    }
    
    @IBAction func ShowDashboard(_ sender: Any){
        let str = TextField.text ?? ""
        if(str.count != 0){
            performSegue(withIdentifier: "ShowDashboard", sender: nil)
        }
    }

}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.calculatePoints(for: 0)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}

extension CAGradientLayer {
    
    /// Sets the start and end points on a gradient layer for a given angle.
    ///
    /// - Important:
    /// *0°* is a horizontal gradient from left to right.
    ///
    /// With a positive input, the rotational direction is clockwise.
    ///
    ///    * An input of *400°* will have the same output as an input of *40°*
    ///
    /// With a negative input, the rotational direction is clockwise.
    ///
    ///    * An input of *-15°* will have the same output as *345°*
    ///
    /// - Parameters:
    ///     - angle: The angle of the gradient.
    ///
    public func calculatePoints(for angle: CGFloat) {
        
        
        var ang = (-angle).truncatingRemainder(dividingBy: 360)
        
        if ang < 0 { ang = 360 + ang }
        
        let n: CGFloat = 0.5
        
        switch ang {
            
        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            startPoint = a
            endPoint = b
            
        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            startPoint = a
            endPoint = b
            
        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
            startPoint = a
            endPoint = b
            
        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            startPoint = a
            endPoint = b
            
        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            startPoint = a
            endPoint = b
            
        }
    }
    
    /// Private function to aid with the math when calculating the gradient angle
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }
    
    
    // Overloads
    
    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Int) {
        calculatePoints(for: CGFloat(angle))
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Float) {
        calculatePoints(for: CGFloat(angle))
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Double) {
        calculatePoints(for: CGFloat(angle))
    }
    
}
