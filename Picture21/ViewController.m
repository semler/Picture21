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
#import "PictureManager.h"
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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-120, screenHeight/2-40, 240, 80)];
    [button setTitle:@"画像を読み込み(名前1+20枚)" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-120, screenHeight/2, 240, 80)];
//    [button2 setTitle:@"画像を読み込み(普通1+20枚)" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(load2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)load {
    [PictureManager sharedManager].isNameMode = YES;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

//- (void)load2 {
//    [PictureManager sharedManager].isNameMode = NO;
//    [self.navigationController presentViewController:picker animated:YES completion:nil];
//}

@end
