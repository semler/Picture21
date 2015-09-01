//
//  Picture6ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/31.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture6ViewController.h"

@interface Picture6ViewController () {
    IBOutletCollection(UILabel) NSArray *labels;
    IBOutletCollection(UIImageView) NSArray *imageViews;
}
@end

@implementation Picture6ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    for (int i = 0; i < labels.count; i ++) {
        UILabel *label = [labels objectAtIndex:i];
        label.text = [NSString stringWithFormat:@"%d", [[_pictures objectAtIndex:i] intValue]+1];
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], [[_pictures objectAtIndex:i] intValue], @".jpg"];
        UIImageView *imageView = [imageViews objectAtIndex:i];
        imageView.image = [UIImage imageWithContentsOfFile:path];
    }
}

@end
