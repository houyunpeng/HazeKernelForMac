//
//  MyFilter.h
//  HYPFaceDetector
//
//  Created by hyp on 2017/11/22.
//  Copyright © 2017年 hyp. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface MyFilter : CIFilter
{
    CIImage* inputImage;
    CIColor* inputColor;
    NSNumber* inputDistance;
    NSNumber* inputSlope;
}
@end
