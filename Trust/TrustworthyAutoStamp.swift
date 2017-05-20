//
//  TrustworthyAutoStamp.swift
//  PaparazzoExample
//
//  Created by Толстой Егор on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

import Foundation
import Paparazzo

class TrustworthyAutoStamp: Filter {

    public var preview: UIImage = UIImage()
    
    public var title: String = "Техосмотр"
    
    public func apply(_ sourceImage: UIImage, completion: @escaping ((_ resultImage: UIImage) -> Void)){
        let stamp = UIImage.init(named: "stamp")
        
        let size = sourceImage.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let backgroundRect = CGRect.init(x: 0,
                                         y: 0,
                                         width: size.width,
                                         height: size.height)
        sourceImage.draw(in: backgroundRect)
        
        let lesserSize = backgroundRect.width < backgroundRect.height ? backgroundRect.width : backgroundRect.height
        let stampSideSize = lesserSize / 2
        
        let offset = backgroundRect.width / 32
        let stampRect = CGRect.init(x: backgroundRect.width - stampSideSize - offset,
                                    y: backgroundRect.height - stampSideSize - offset,
                                    width: stampSideSize,
                                    height: stampSideSize)
        stamp?.draw(in: stampRect)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        completion(newImage)
    }
}
