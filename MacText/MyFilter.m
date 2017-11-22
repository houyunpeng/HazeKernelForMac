//
//  MyFilter.m
//  HYPFaceDetector
//
//  Created by hyp on 2017/11/22.
//  Copyright © 2017年 hyp. All rights reserved.
//

#import "MyFilter.h"
#import <CoreImage/CoreImage.h>
@implementation MyFilter

+ (void)initialize
{
    [CIFilter registerFilterName: @"MyHazeRemover"
                     constructor: self
                 classAttributes:
     @{kCIAttributeFilterDisplayName : @"Haze Remover",
       kCIAttributeFilterCategories : @[
               kCICategoryColorAdjustment, kCICategoryVideo,
               kCICategoryStillImage, kCICategoryInterlaced,
               kCICategoryNonSquarePixels]}
     ];
}


static CIKernel* customKernel = nil;

-(instancetype)init
{
    if (customKernel == nil) {
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSString* code = [NSString stringWithContentsOfFile:[bundle pathForResource:@"MyKernel" ofType:@"kernel"] encoding:NSUTF8StringEncoding error:nil];
        
        NSArray* kernels = [CIKernel kernelsWithString:code];
        customKernel = kernels.firstObject;
        
    }
    return [super init];
}
- (NSDictionary *)customAttributes
{
    return @{
             @"inputDistance" :  @{
                     kCIAttributeMin       : @0.0,
                     kCIAttributeMax       : @1.0,
                     kCIAttributeSliderMin : @0.0,
                     kCIAttributeSliderMax : @0.7,
                     kCIAttributeDefault   : @0.2,
                     kCIAttributeIdentity  : @0.0,
                     kCIAttributeType      : kCIAttributeTypeScalar
                     },
             @"inputSlope" : @{
                     kCIAttributeSliderMin : @-0.01,
                     kCIAttributeSliderMax : @0.01,
                     kCIAttributeDefault   : @0.00,
                     kCIAttributeIdentity  : @0.00,
                     kCIAttributeType      : kCIAttributeTypeScalar
                     },
             kCIInputColorKey : @{
                     kCIAttributeDefault : [CIColor colorWithRed:1.0
                                                           green:1.0
                                                            blue:1.0
                                                           alpha:1.0]
                     },
             };
}
- (CIImage *)outputImage
{
    CISampler *src = [CISampler samplerWithImage: inputImage];
    
    return [self apply: customKernel, src, inputColor, inputDistance,
            inputSlope, kCIApplyOptionDefinition, [src definition], nil];
    
}
+ (CIFilter *)filterWithName: (NSString *)name
{
    CIFilter  *filter;
    filter = [[self alloc] init];
    return filter;
}

@end
