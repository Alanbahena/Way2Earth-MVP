//
//  Extensions.swift
//  InstagramFirestoreTutorial
//
//  Created by Alan Bahena on 1/7/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit
import AVFoundation
import JGProgressHUD

extension UIButton {
    func attributedTittle(firstPart : String, secondPart: String){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.9), .font: UIFont.RobotoRegular(size: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart)  ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.9), .font: UIFont.robotoBold(size: 16)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}

extension UIFont {
    static func merriWeatherBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Merriweather-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func openSansRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func RobotoRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size) ?? .systemFont(ofSize: size)
    }
}

extension UIImage {
    /**
     Calculates the best height of the image for available width.
     */
    func height(forWidth width: CGFloat) -> CGFloat {
        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        let rect = AVMakeRect(
            aspectRatio: size,
            insideRect: boundingRect
        )
        return rect.size.height
    }
}


extension UIColor {
    
    class var spaceColor: UIColor {
        return UIColor(red: 7.0 / 255.0 , green: 9.0 / 255.0 , blue: 13.0 / 255.0 , alpha: 0.9)
    }
    
    class var placeHolderSpaceColor: UIColor {
        return UIColor(red: 7.0 / 255.0 , green: 9.0 / 255.0 , blue: 13.0 / 255.0 , alpha: 0.7)
    }
    
    class var buttonbackgroundBlueColor: UIColor {
        return UIColor(red: 5.0 / 255.0 , green: 131.0 / 255.0 , blue: 242.0 / 255.0 , alpha: 0.75)
    }
    
    class var buttonUnabledbackgroundBlueColor: UIColor {
        return UIColor(red: 5.0 / 255.0 , green: 131.0 / 255.0 , blue: 242.0 / 255.0 , alpha: 0.25)
    }
}

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
 
    
}

extension UIButton {
    
    func attributedTitle (firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key:Any] = [.foregroundColor: UIColor (white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart)", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key:Any] = [.foregroundColor: UIColor (white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}


extension String {
    /**
     Calculates the best height of the text for available width and font used.
     */
    func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(rect.height)
    }
}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}

extension UIView {
    
    func addConstraintsAlignedToSuperview(top: CGFloat = 0,
                                          leading: CGFloat = 0,
                                          bottom: CGFloat = 0,
                                          trailing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .top,
                relatedBy: .equal,
                toItem: superview,
                attribute: .top,
                multiplier: 1,
                constant: top
            )
        )
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .leading,
                relatedBy: .equal,
                toItem: superview,
                attribute: .leading,
                multiplier: 1,
                constant: leading
            )
        )
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: superview,
                attribute: .bottom,
                multiplier: 1,
                constant: bottom
            )
        )
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: superview,
                attribute: .trailing,
                multiplier: 1,
                constant: trailing
            )
        )
    }
}

