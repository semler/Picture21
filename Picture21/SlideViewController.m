//
//  SlideViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/09/01.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "SlideViewController.h"
#define screenWidth            [UIScreen mainScreen].bounds.size.width
#define screenHeight           [UIScreen mainScreen].bounds.size.height

@interface SlideViewController () {
    UIImageView *imageView;
    NSMutableArray *slideShowImages;
    int slideShowImageNum;
    NSTimer *slideShowTimer;
    float slideShowTimerInterval;
    float slideShowFadeInDuration;
    int currentImageIndex;
    BOOL isRunningSlideShow;
}

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    //スライドショーの設定
    [self initSlideShowImages];
    //スライドショーで表示する画像を初期化
    [self initSlideShowImageView];
    //スライドショー開始
    [self startSlideShow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//スライドショーで表示するイメージを初期化
- (void)initSlideShowImages
{
    //スライドショーで使用する画像タイトル定義
    slideShowImages = [NSMutableArray array];
    for (int i = 0; i < 21; i ++) {
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], i, @".jpg"];
        [slideShowImages addObject:path];
    }
    //総画像ファイル数を取得
    slideShowImageNum = (int)slideShowImages.count + 1;
    //最初に表示する画像IDを設定
    currentImageIndex = 0;
    //スライドが切り替わる秒数を設定
    slideShowTimerInterval = 2.0f;
    //フェードイン秒数
    slideShowFadeInDuration = 0.3;
}

//スライドショーで表示するイメージを配置
- (void)initSlideShowImageView
{
    //UIImageViewを初期化
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(267, 114, 490, 539)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    //UIImageViewに画像を表示
    imageView.hidden = YES;
    //UIImageViewを UIViewに乗せる
    UIView *slideShowView = [[UIView alloc] init];
    slideShowView = imageView;
    //ステージに配置
    [self.view addSubview:slideShowView];
}

//スライドショーを開始する
- (void)startSlideShow
{
    //既にスライドショーが再生中であれば実行しない
    if (isRunningSlideShow) {
        return;
    }
    //最後の画像になったらIDをリセットする
    if ([self isLastImage]) {
        currentImageIndex = -1;
    }
    //スライドショーのタイマー定義
    slideShowTimer = [NSTimer scheduledTimerWithTimeInterval:slideShowTimerInterval
                                                           target:self
                                                         selector:@selector(nextSlideShow:)
                                                         userInfo:nil
                                                          repeats:YES];
    //スライドショー再生中フラグ
    isRunningSlideShow = YES;
}

//スライドショーで次の写真を表示する
- (void)nextSlideShow:(NSTimer*)timer
{
    //最後の画像になったらIDをリセットする
    if ([self isLastImage]) {
//        currentImageIndex = -1;
        [self stopSlideShow];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    //次の画像を表示
    [self changeToNextImage];
}

//次の画像へ切り替える
- (void)changeToNextImage
{
    //画像IDを送る
    currentImageIndex++;
    //画像ファイル名をセット
    if (currentImageIndex == 0) {
        imageView.hidden = YES;
    } else if (currentImageIndex == 22) {
        imageView.hidden = YES;
    } else {
        imageView.image = [UIImage imageWithContentsOfFile:[slideShowImages objectAtIndex:currentImageIndex-1]];
        imageView.hidden = NO;
    }
    //フェードイン開始
    imageView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:slideShowFadeInDuration];
    imageView.alpha = 1;
    [UIView commitAnimations];
}

//スライドショーを停止する
- (void)stopSlideShow
{
    [slideShowTimer invalidate];
    isRunningSlideShow = NO;
}

//スライドショーイベントの呼び出し
- (void)callSlideShow
{
    if (isRunningSlideShow) {
        [self stopSlideShow];
    } else {
        [self startSlideShow];
    }
    isRunningSlideShow = !isRunningSlideShow;
}

//最後のイメージであるか
- (BOOL)isLastImage
{
    return (slideShowImageNum <= currentImageIndex);
}


@end
