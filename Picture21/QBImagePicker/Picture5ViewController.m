//
//  Picture5ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/09/03.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture5ViewController.h"

@interface Picture5ViewController () {
    IBOutletCollection(UILabel) NSArray *labels;
    IBOutletCollection(UIImageView) NSArray *imageViews;
}
@end

@implementation Picture5ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    for (int i = 0; i < labels.count; i ++) {
        UILabel *label = [labels objectAtIndex:i];
        if ([[_pictures objectAtIndex:i] intValue] != 0) {
            label.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:i] intValue]];
        }
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:i] intValue], @".jpg"];
        UIImageView *imageView = [imageViews objectAtIndex:i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageWithContentsOfFile:path];
    }
}

@end
