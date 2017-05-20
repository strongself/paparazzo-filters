//
//  ObjectDetectionFilter.swift
//  PaparazzoExample
//
//  Created by Смаль Вадим on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

import Foundation
import Paparazzo

public class ObjectDetectionFilter: Filter {
    
    public var preview: UIImage = UIImage()
    let deepBeliefBridge = DeepBeliefBridge()
    
    public var title: String = "ObjectDetectionFilter"
    
    public func apply(_ sourceImage: UIImage, completion: @escaping ((_ resultImage: UIImage) -> Void)){
        
        deepBeliefBridge.process(sourceImage) { (results: Dictionary) in
            print(results)
            guard let res = results as? Dictionary<String,NSNumber> else {
                completion(sourceImage)
                return
            }
            var textResult : String = ""
            var maxValue : Double = 0.0
            for (label, value) in res {
                if value.doubleValue > maxValue {
                    maxValue = value.doubleValue
                    textResult = "\(label) \(value)"
                }
            }
            let output = self.textToImage(drawText: textResult as NSString, inImage: sourceImage, atPoint: CGPoint(x: 0, y: 0))
            completion(output)
        }
    }
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        
        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: max(inImage.size.width, inImage.size.height) / 20)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ]
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: inImage.size.width, height: inImage.size.height)))
        
        // Create a point within the space that is as bit as the image
        
        let rect = CGRect(origin: CGPoint(x:atPoint.x, y:atPoint.y), size: CGSize(width: inImage.size.width, height: inImage.size.height))
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
        
    }
    
}
