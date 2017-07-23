//
//  ViewController.swift
//  GridAnimation
//
//  Created by Marcus Man on 23/7/2017.
//  Copyright © 2017 Marcus Man. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numViewPerRow = 15
    var cells = [String: UIView]()
    var selectedCell: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = view.frame.width / CGFloat(numViewPerRow)
        let numRows = Int(view.frame.height / width)


        for row in 0...numRows{
            for col in 0...numViewPerRow{
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(col) * width, y: CGFloat(row) * width, width: width, height: width)
                cellView.layer.borderColor = UIColor.black.cgColor
                cellView.layer.borderWidth = 0.5
                view.addSubview(cellView)

                let key = "\(col)|\(row)"
                cells[key] = cellView
            }
        }

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }

    func handlePan(gesture: UIPanGestureRecognizer){

        let location = gesture.location(in: view)
        let width = view.frame.width / CGFloat(numViewPerRow)

        let col = Int(location.x / width)
        let row = Int(location.y / width)

        let key = "\(col)|\(row)"
        guard let cellView = cells[key] else {return}

        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
                //cellView?.backgroundColor = .black
            }, completion: nil)
        }

        selectedCell = cellView
        //cellView?.backgroundColor = .white

        view.bringSubview(toFront: cellView)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(2, 2, 2)
            //cellView?.backgroundColor = .black
        }, completion: nil)

        if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
                //cellView?.backgroundColor = .black
            }, completion: nil)
        }


        /** inefficient way to find the location of cell
         var locationCount = 0
        //retieve all subview in superview
        for subview in view.subviews {
            print("subview: ", subview.frame)
            //return whether a rectangle contains a specific point
            if subview.frame.contains(location) {
                subview.backgroundColor = .black
                print(locationCount)
            }
            locationCount += 1
        }
        **/

    }

    fileprivate func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }



}

