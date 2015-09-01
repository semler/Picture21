//
//  Picture2ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/31.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture2ViewController.h"

@interface Picture2ViewController () {
    __weak IBOutlet UILabel *label1;
    __weak IBOutlet UILabel *label2;
    __weak IBOutlet UIImageView *imageView1;
    __weak IBOutlet UIImageView *imageView2;
}
@end

@implementation Picture2ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    label1.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:0] intValue]+1];
    label2.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:1] intValue]+1];
    
    NSString *path1 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:0] intValue], @".jpg"];
    NSString *path2 = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:1] intValue], @".jpg"];
    imageView1.image = [UIImage imageWithContentsOfFile:path1];
    imageView2.image = [UIImage imageWithContentsOfFile:path2];
    
}

@end
