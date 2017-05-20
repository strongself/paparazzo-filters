//
//  InstantFilter.swift
//  PaparazzoExample
//
//  Created by Толстой Егор on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

import UIKit

class InstantFilter: CoreImageFilterBase {
    convenience init() {
        self.init(ciFilterName: "CIPhotoEffectInstant", preview: UIImage(), title: "Ваниль")
    }
}
