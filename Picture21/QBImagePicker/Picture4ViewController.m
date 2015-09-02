//
//  Picture4ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/31.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture4ViewController.h"

@interface Picture4ViewController () {
    __weak IBOutlet UILabel *label1;
    __weak IBOutlet UILabel *label2;
    __weak IBOutlet UILabel *label3;
    __weak IBOutlet UILabel *label4;
    __weak IBOutlet UIImageView *imageView1;
    __weak IBOutlet UIImageView *imageView2;
    __weak IBOutlet UIImageView *imageView3;
    __weak IBOutlet UIImageView *imageView4;
}
@end

@implementation Picture4ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    if ([[_pictures objectAtIndex:0] intValue] != 0) {
        label1.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:0] intValue]];
    }
    if ([[_pictures objectAtIndex:1] intValue] != 0) {
        label2.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:1] intValue]];
    }
    if ([[_pictures objectAtIndex:2] intValue] != 0) {
        label3.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:2] intValue]];
    }
    if ([[_pictures objectAtIndex:3] intValue] != 0) {
        label4.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:3] intValue]];
    }
    
    NSString *path1 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:0] intValue], @".jpg"];
    NSString *path2 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:1] intValue], @".jpg"];
    NSString *path3 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:2] intValue], @".jpg"];
    NSString *path4 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:3] intValue], @".jpg"];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = YES;
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.clipsToBounds = YES;
    imageView3.contentMode = UIViewContentModeScaleAspectFill;
    imageView3.clipsToBounds = YES;
    imageView4.contentMode = UIViewContentModeScaleAspectFill;
    imageView4.clipsToBounds = YES;
    imageView1.image = [UIImage imageWithContentsOfFile:path1];
    imageView2.image = [UIImage imageWithContentsOfFile:path2];
    imageView3.image = [UIImage imageWithContentsOfFile:path3];
    imageView4.image = [UIImage imageWithContentsOfFile:path4];
}

@end
