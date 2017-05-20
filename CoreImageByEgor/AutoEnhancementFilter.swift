//
//  AutoEnhancementFilter.swift
//  PaparazzoExample
//
//  Created by Толстой Егор on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

import Foundation
import Paparazzo

class AutoEnhancementFilter: Filter {
    public var preview: UIImage = UIImage()
    
    public var title: String = "Сделать хорошо"
    
    public func apply(_ sourceImage: UIImage, completion: @escaping ((_ resultImage: UIImage) -> Void)){
        var ciImage = CIImage(image: sourceImage)
        let adjustments = ciImage?.autoAdjustmentFilters()
        
        adjustments?.forEach({ (filter) in
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            ciImage = filter.outputImage
        })
        
        let context = CIContext(options: nil)
        if let output = ciImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                completion(processedImage)
                return
            }
        }
        
        completion(sourceImage)
    }
}
