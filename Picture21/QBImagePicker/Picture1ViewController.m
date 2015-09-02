//
//  Picture1ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/09/01.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture1ViewController.h"

@interface Picture1ViewController () {
    __weak IBOutlet UILabel *label;
    __weak IBOutlet UIImageView *imageView;
}
@end

@implementation Picture1ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    if ([[_pictures objectAtIndex:0] intValue] != 0) {
        label.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:0] intValue]];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:0] intValue], @".jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageWithContentsOfFile:path];
    
}

@end
