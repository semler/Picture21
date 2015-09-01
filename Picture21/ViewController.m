//
//  ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/26.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "ViewController.h"
#import "QBImagePickerController.h"
#import "SlideViewController.h"
#define screenWidth            [UIScreen mainScreen].bounds.size.width
#define screenHeight           [UIScreen mainScreen].bounds.size.height

@interface ViewController () <QBImagePickerControllerDelegate> {
    QBImagePickerController *picker;
    UIButton *slideButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    picker = [QBImagePickerController new];
    picker.delegate = self;
    picker.mediaType = QBImagePickerMediaTypeAny;
    picker.allowsMultipleSelection = YES;
    picker.showsNumberOfSelectedAssets = YES;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-100, screenHeight/2-80, 200, 80)];
    [button setTitle:@"画像を読み込み" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    slideButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-100, screenHeight/2, 200, 80)];
    [slideButton setTitle:@"スライドショー" forState:UIControlStateNormal];
    [slideButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [slideButton addTarget:self action:@selector(slide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slideButton];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL show = YES;
    for (int i = 0; i < 11; i ++) {
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], i, @".jpg"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            show = NO;
            break;
        }
    }
    if (show) {
        slideButton.enabled = YES;
    } else {
        slideButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)load {
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void)slide {
//    SlideViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"slideShow"];
//    [self.navigationController presentViewController:controller animated:YES completion:nil];
    SlideViewController *controller = [[SlideViewController alloc] init];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

@end
