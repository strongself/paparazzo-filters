//
//  DeepBeliefBridge.h
//  PaparazzoExample
//
//  Created by Смаль Вадим on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^DeepBeliefCompletion)(NSDictionary * _Nonnull result);

@interface DeepBeliefBridge : NSObject

- (void)process:(UIImage * _Nonnull)image
     complition:(DeepBeliefCompletion _Nonnull)completion;

@end
