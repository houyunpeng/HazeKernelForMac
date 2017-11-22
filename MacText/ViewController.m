//
//  ViewController.m
//  MacText
//
//  Created by hyp on 2017/11/22.
//  Copyright © 2017年 hyp. All rights reserved.
//

#import "ViewController.h"
#import "MyFilter.h"
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [MyFilter class];
    
    NSArray* arr = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    for (NSString* str in arr) {
        CIFilter* f = [CIFilter filterWithName:str];
        NSDictionary* d = f.attributes;
        
        if ([str isEqualToString:@"MyHazeRemover"]) {
            NSLog(@"----%@",d);
            NSLog(@"----%@",str);
        }
        
        
    }
    
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"jpg"]];
    
    CIFilter* filter = [CIFilter filterWithName:@"MyHazeRemover" withInputParameters:@{kCIInputImageKey: [CIImage imageWithContentsOfURL:url],kCIInputColorKey: [CIColor colorWithRed:0.7 green:0.9 blue:1]}];
    //    [filter setValue:@0.5 forKey:@"inputDistance"];
    [filter setValue:@0.01 forKey:@"inputDistance"];
    CIImage* image = [filter outputImage];
    CIContext* contex = [[CIContext alloc] init];
    _imageViewAfter.image = [[NSImage alloc] initWithCGImage:[contex createCGImage:image fromRect:image.extent] size:_imageViewAfter.frame.size];
    
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
