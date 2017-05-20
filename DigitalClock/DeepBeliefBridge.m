//
//  DeepBeliefBridge.m
//  PaparazzoExample
//
//  Created by Смаль Вадим on 20/05/2017.
//  Copyright © 2017 Avito. All rights reserved.
//

#import "DeepBeliefBridge.h"
#import <DeepBelief/DeepBelief.h>

@implementation DeepBeliefBridge

- (void)process:(UIImage *)image
     complition:(DeepBeliefCompletion)completion {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    
    NSString* networkPath = [[NSBundle mainBundle] pathForResource:@"jetpac" ofType:@"ntwk"];
    if (networkPath == NULL) {
        fprintf(stderr, "Couldn't find the neural network parameters file - did you add it as a resource to your application?\n");
        assert(false);
    }
    void* network = jpcnn_create_network([networkPath UTF8String]);
    assert(network != NULL);
    
    void* inputImage = jpcnn_create_image_buffer_from_file([filePath UTF8String]);
    
    float* predictions;
    int predictionsLength;
    char** predictionsLabels;
    int predictionsLabelsLength;
    jpcnn_classify_image(network, inputImage, 0, 0, &predictions, &predictionsLength, &predictionsLabels, &predictionsLabelsLength);
    
    jpcnn_destroy_image_buffer(inputImage);
    
    NSMutableDictionary* newValues = [NSMutableDictionary dictionary];
    for (int index = 0; index < predictionsLength; index += 1) {
        const float predictionValue = predictions[index];
        char* label = predictionsLabels[index % predictionsLabelsLength];
        NSString* labelObject = [NSString stringWithCString: label];
        NSNumber* valueObject = [NSNumber numberWithFloat: predictionValue];
        [newValues setObject: valueObject forKey: labelObject];
        NSLog(@"%@ %@",labelObject, valueObject);
    }
    
    jpcnn_destroy_network(network);
    
    completion(newValues);
}

@end
