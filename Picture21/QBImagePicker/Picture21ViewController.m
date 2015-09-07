//
//  Picture21ViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/08/29.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "Picture21ViewController.h"
#import "Picture1ViewController.h"
#import "Picture2ViewController.h"
#import "Picture3ViewController.h"
#import "Picture4ViewController.h"
#import "Picture5ViewController.h"
#import "Picture6ViewController.h"
#import "PictureManager.h"
#import "ClickButton.h"
#import "SlideViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface Picture21ViewController () <AVAudioPlayerDelegate> {
    
    IBOutletCollection(UIImageView) NSArray *imageViews;
    IBOutletCollection(ClickButton) NSArray *buttons;
    __weak IBOutlet UIBarButtonItem *okButton;
    __weak IBOutlet UILabel *messageLabel;
    NSMutableArray *pictures;
    __weak IBOutlet UIView *bgView;
}

@property(nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)buttonsPressed:(id)sender;
- (IBAction)okButtonPressed:(id)sender;
- (IBAction)slide:(id)sender;
- (IBAction)clear:(id)sender;

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
    [okButton setEnabled:NO];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([PictureManager sharedManager].isSlide) {
        NSError *error = nil;
        // 再生する audio ファイルのパスを取得
        NSString *path = [[NSBundle mainBundle] pathForResource:@"drop" ofType:@"wav"];
        // パスから、再生するURLを作成する
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        // auido を再生するプレイヤーを作成する
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        // エラーが起きたとき
        if ( error != nil )
        {
            NSLog(@"Error %@", [error localizedDescription]);
        }
        // 自分自身をデリゲートに設定
        [self.audioPlayer setDelegate:self];
        [self.audioPlayer setCurrentTime:0];
        [self performSelector:@selector(play) withObject:nil afterDelay:0.3];

        bgView.frame = CGRectMake(0, -704, bgView.frame.size.width, bgView.frame.size.height);
        [UIView animateWithDuration:0.3f animations:^{
            bgView.frame = CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height);
        }];
        [PictureManager sharedManager].isSlide = NO;
    }
}

- (IBAction)buttonsPressed:(id)sender {
    ClickButton *button = (ClickButton *)sender;
    
    if (button.isClicked) {
        button.isClicked = NO;
    } else {
        button.isClicked = YES;
    }
    
    int sum = 0;
    NSString *message = @"選択した写真：";
    for (ClickButton *button in buttons) {
        if (button.isClicked) {
            message = [NSString stringWithFormat:@"%@%d ", message, (int)button.tag];
            sum ++;
        }
    }
    messageLabel.text = message;
    if (sum >= 1 && sum <= 6) {
        [okButton setEnabled:YES];
    } else {
        [okButton setEnabled:NO];
    }
}

- (IBAction)okButtonPressed:(id)sender {
    
    [pictures removeAllObjects];
    for (ClickButton *button in buttons) {
        if (button.isClicked) {
            [pictures addObject:[NSNumber numberWithInt:(int)button.tag]];
        }
    }
    
    if (pictures.count == 1) {
        Picture1ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"picture1"];
        controller.pictures = pictures;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (pictures.count == 2) {
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
    } else if (pictures.count == 5) {
        Picture5ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"picture5"];
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

- (IBAction)slide:(id)sender {
    SlideViewController *controller = [[SlideViewController alloc] init];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

- (IBAction)clear:(id)sender {
    for (ClickButton *button in buttons) {
        button.isClicked = NO;
    }
    messageLabel.text = @"";
    [okButton setEnabled:NO];
}

-(void) play {
    [self.audioPlayer play];
}

@end
