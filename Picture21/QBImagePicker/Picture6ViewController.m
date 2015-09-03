//
//  Picture6ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/31.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture6ViewController.h"

@interface Picture6ViewController () {
    IBOutletCollection(UIImageView) NSArray *numbers;
    IBOutletCollection(UIImageView) NSArray *imageViews;
}
@end

@implementation Picture6ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    for (int i = 0; i < numbers.count; i ++) {
        UIImageView *numberImage = [numbers objectAtIndex:i];
        NSString *imageName = [NSString stringWithFormat:@"%d%@", [[_pictures objectAtIndex:i] intValue], @"_off"];
        numberImage.image = [UIImage imageNamed:imageName];
        
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:i] intValue], @".jpg"];
        UIImageView *imageView = [imageViews objectAtIndex:i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageWithContentsOfFile:path];
    }
}

@end
