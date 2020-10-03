//
//  ViewController.swift
//  MyProject
//
//  Created by محمود محمد on 12/8/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 @IBOutlet weak var onBoarding: UIView!
 @IBOutlet weak var mainView: UIView!
 @IBOutlet weak var circleView1: UIView!
 @IBOutlet weak var circleView2: UIView!
 @IBOutlet weak var circleView3: UIView!
 @IBOutlet var button: UIButton!
 @IBOutlet weak var label91: UILabel!
 @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let colorOne = UIColor(hexString:"#5927FF")!
        let colorTwo = UIColor(hexString: "#8160EF")!
        onBoarding.applyGradient(colours: [colorTwo, colorOne])
        mainView.applyGradient(colours: [colorTwo, colorOne])
        //1
        circleView1.layer.cornerRadius = circleView1.frame.size.width/2
        circleView1.clipsToBounds = true
        circleView1.layer.borderColor = UIColor.init(hexString:"#44E4A5")?.cgColor
        circleView1.layer.borderWidth = 5.0
        //2
        circleView2.layer.cornerRadius = circleView2.frame.size.width/2
        circleView2.clipsToBounds = true
        circleView2.layer.borderColor = UIColor.init(hexString:"#44E4A5")?.cgColor
        circleView2.layer.borderWidth = 5.0
        //3
        circleView3.layer.cornerRadius = circleView3.frame.size.width/2
        circleView3.clipsToBounds = true
        circleView3.layer.borderColor = UIColor.init(hexString:"#44E4A5")?.cgColor
        circleView3.layer.borderWidth = 5.0
        //
        button.setImage(UIImage(named: "OnBoardingButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //
        let maskPath = UIBezierPath(roundedRect: label91.bounds,
                                    byRoundingCorners: [.bottomLeft, .topLeft],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        label91.layer.mask = shape
        //
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    @IBAction func showDashboard(_ sender: Any)
    {
        let str = TextField.text ?? ""
        if(str.count != 0)
        {
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
        
        let varN: CGFloat = 0.5
        
        switch ang {
            
        case 0...45, 315...360:
            let varA = CGPoint(x: 0, y: varN * tanx(ang) + varN)
            let varB = CGPoint(x: 1, y: varN * tanx(-ang) + varN)
            startPoint = varA
            endPoint = varB
            
        case 45...135:
            let varA = CGPoint(x: varN * tanx(ang - 90) + varN, y: 1)
            let varB = CGPoint(x: varN * tanx(-ang - 90) + varN, y: 0)
            startPoint = varA
            endPoint = varB
            
        case 135...225:
            let varA = CGPoint(x: 1, y: varN * tanx(-ang) + varN)
            let varB = CGPoint(x: 0, y: varN * tanx(ang) + varN)
            startPoint = varA
            endPoint = varB
            
        case 225...315:
            let varA = CGPoint(x: varN * tanx(-ang - 90) + varN, y: 0)
            let varB = CGPoint(x: varN * tanx(ang - 90) + varN, y: 1)
            startPoint = varA
            endPoint = varB
            
        default:
            let varA = CGPoint(x: 0, y: varN)
            let varB = CGPoint(x: 1, y: varN)
            startPoint = varA
            endPoint = varB
            
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
