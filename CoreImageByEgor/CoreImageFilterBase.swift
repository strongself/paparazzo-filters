//
//  CoreImageFilterBase.swift
//  PaparazzoExample
//
//  Created by Толстой Егор on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

import Foundation
import Paparazzo

class CoreImageFilterBase: Filter {
    public var preview: UIImage
    
    public var title: String
    
    private var ciFilterName: String
    
    init(ciFilterName: String, preview: UIImage, title: String) {
        self.ciFilterName = ciFilterName
        self.preview = preview
        self.title = title
    }
    
    public func apply(_ sourceImage: UIImage, completion: @escaping ((_ resultImage: UIImage) -> Void)){
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: self.ciFilterName) {
            let beginImage = CIImage(image: sourceImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    completion(processedImage)
                    return
                }
            }
        }
        completion(sourceImage)
    }

}
