//
//  ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/26.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "ViewController.h"
#import "QBImagePickerController.h"
#define screenWidth            [UIScreen mainScreen].bounds.size.width
#define screenHeight           [UIScreen mainScreen].bounds.size.height

@interface ViewController () <QBImagePickerControllerDelegate> {
    QBImagePickerController *picker;
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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-100, screenHeight/2-40, 200, 80)];
    [button setTitle:@"画像を読み込み" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)load {
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

@end
