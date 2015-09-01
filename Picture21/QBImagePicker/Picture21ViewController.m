//
//  Picture21ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/29.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture21ViewController.h"
#import "Picture2ViewController.h"
#import "Picture3ViewController.h"
#import "Picture4ViewController.h"
#import "Picture6ViewController.h"
#import "PictureManager.h"
#import "ClickButton.h"

@interface Picture21ViewController () {
    
    IBOutletCollection(UIImageView) NSArray *imageViews;
    IBOutletCollection(ClickButton) NSArray *buttons;
    __weak IBOutlet UIBarButtonItem *okButton;
    NSMutableArray *pictures;
    
}

- (IBAction)buttonsPressed:(id)sender;
- (IBAction)okButtonPressed:(id)sender;

@end

@implementation Picture21ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    for (UIImageView *imageView in imageViews) {
        
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], (int)imageView.tag, @".jpg"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageWithContentsOfFile:path];
    }
    
    pictures = [NSMutableArray array];
    
}

- (IBAction)buttonsPressed:(id)sender {
    ClickButton *button = (ClickButton *)sender;
    
    if (button.isClicked) {
        button.isClicked = NO;
        button.backgroundColor = [UIColor clearColor];
//        button.alpha = 0;
    } else {
        button.isClicked = YES;
        button.backgroundColor = [UIColor grayColor];
        button.alpha = 0.5;
    }
    
}

- (IBAction)okButtonPressed:(id)sender {
    
    [pictures removeAllObjects];
    for (ClickButton *button in buttons) {
        if (button.isClicked) {
            [pictures addObject:[NSNumber numberWithInt:(int)button.tag]];
        }
    }
    
    if (pictures.count == 2) {
        Picture2ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"picture2"];
        controller.pictures = pictures;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (pictures.count == 3) {
        Picture3ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"picture3"];
        controller.pictures = pictures;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (pictures.count == 4) {
        Picture4ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"picture4"];
        controller.pictures = pictures;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (pictures.count == 6) {
        Picture6ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"picture6"];
        controller.pictures = pictures;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        //
    }
}
@end
