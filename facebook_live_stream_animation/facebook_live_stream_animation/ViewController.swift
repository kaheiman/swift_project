//
//  ViewController.swift
//  facebook_live_stream_animation
//
//  Created by Marcus Man on 23/7/2017.
//  Copyright © 2017 Marcus Man. All rights reserved.
//

/**
 Login flow
    1.create tap gesture -> handleTap
    2.handleTap (generate 10 animatioins) -> generateAnimatedViews
    3.generatedAnimatedViews
        -> randomize image data into uiimageview
        -> create a custom path using UIBezierPath
        -> create animation layout with the custom path
        -> add layer to imageview
        -> add subview to view

 **/

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
//
//        view.addSubview(curvedView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

    }

    func handleTap(){
        (0...10).forEach{ (_) in
            generateAnimatedViews()
            colorAnimatedViews()
        }
    }

    fileprivate func generateAnimatedViews(){
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        //drand gives you a random number from 0 to 1 -> dimension {20 to 30}
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath

        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        imageView.layer.add(animation, forKey:  nil)
        view.addSubview(imageView)
    }

    fileprivate func colorAnimatedViews(){
        let colorKeyframeAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorKeyframeAnimation.values = [
                                            UIColor.red.cgColor,
                                            UIColor.green.cgColor,
                                            UIColor.blue.cgColor,
                                            UIColor.cyan.cgColor,
                                            UIColor.darkGray.cgColor]
        colorKeyframeAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        colorKeyframeAnimation.duration = 2
        view.layer.add(colorKeyframeAnimation, forKey: nil)
    }

}

func customPath() -> UIBezierPath {

    //define a path for you to render
    let path = UIBezierPath()

    path.move(to: CGPoint(x: 0, y: 350 ))

    let endPoint = CGPoint(x: 400, y: 350)

    let randYShipt = 0
    let cp1 = CGPoint(x: 100, y: 150 - randYShipt)
    let cp2 = CGPoint(x: 200, y: 350 + randYShipt)

    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView{

    override func draw(_ rect: CGRect) {
        //do some fancy thing here

        //path.addLine(to: endPoint) 直線rendering

        let path = customPath()
        path.lineWidth = 3
        //render a line after creating starting and ending point
        path.stroke()
    }
}

