//
//  Picture2ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/31.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture2ViewController.h"

@interface Picture2ViewController () {
    __weak IBOutlet UIImageView *number1;
    __weak IBOutlet UIImageView *number2;
    __weak IBOutlet UIImageView *imageView1;
    __weak IBOutlet UIImageView *imageView2;
}
@end

@implementation Picture2ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    NSString *imageName;
    imageName = [NSString stringWithFormat:@"%d%@", [[_pictures objectAtIndex:0] intValue], @"_off"];
    number1.image = [UIImage imageNamed:imageName];
    imageName = [NSString stringWithFormat:@"%d%@", [[_pictures objectAtIndex:1] intValue], @"_off"];
    number2.image = [UIImage imageNamed:imageName];
    
    NSString *path1 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:0] intValue], @".jpg"];
    NSString *path2 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:1] intValue], @".jpg"];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = YES;
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.clipsToBounds = YES;
    imageView1.image = [UIImage imageWithContentsOfFile:path1];
    imageView2.image = [UIImage imageWithContentsOfFile:path2];
    
}

@end
