//
//  SlideViewController.m
//  Picture21
//
//  Created by 于　超 on 2015/09/01.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "SlideViewController3.h"
#import <AVFoundation/AVFoundation.h>
#import "PictureManager.h"

#define slideShowTimerInterval      1.2f //スライドが切り替わる秒数を設定

@interface SlideViewController3 () <AVAudioPlayerDelegate>{
    UIImageView *imageView;
    NSMutableArray *slideShowImages;
    int slideShowImageNum;
    NSTimer *slideShowTimer;
    float slideShowFadeInDuration;
    int currentImageIndex;
    BOOL isRunningSlideShow;
    UIButton *startButton;
    UIView *moveView;
}

@property(nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation SlideViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //音声再生
    [self initVoice];
    //スライドショーの設定
    [self initSlideShowImages];
    //スライドショーで表示する画像を初期化
    [self initSlideShowImageView];
    
    startButton = [[UIButton alloc] initWithFrame:self.view.frame];
    startButton.backgroundColor = [UIColor clearColor];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    startButton.enabled = YES;
    [self.view addSubview:startButton];
    
    moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    moveView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:moveView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) initVoice {
    NSError *error = nil;
    // 再生する audio ファイルのパスを取得
    NSString *path = [[NSBundle mainBundle] pathForResource:@"slide" ofType:@"wav"];
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
}

//スライドショーで表示するイメージを初期化
- (void)initSlideShowImages
{
    //スライドショーで使用する画像タイトル定義
    slideShowImages = [NSMutableArray array];
    int start;
    if ([PictureManager sharedManager].isNameMode) {
        start = 1;
    } else {
        start = 0;
    }
    for (int i = start; i < 21; i ++) {
        NSString *path = [NSString stringWithFormat:@"%@/%d%@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], i, @".jpg"];
        [slideShowImages addObject:path];
    }
    //総画像ファイル数を取得
    slideShowImageNum = (int)slideShowImages.count;
    //最初に表示する画像IDを設定
    currentImageIndex = 0;
    //フェードイン秒数
    slideShowFadeInDuration = 0.3;
}

//スライドショーで表示するイメージを配置
- (void)initSlideShowImageView
{
    //UIImageViewを初期化
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(267, 115, 490, 539)];
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
    
    moveView.frame = CGRectMake(0, 0, 1, 1);
    [UIView animateWithDuration:1.0f animations:^{
        moveView.frame = CGRectMake(0, 1, 1, 1);
    } completion:^(BOOL finished){
        if (self.audioPlayer.playing) {
            [self.audioPlayer stop];
        }
        [self.audioPlayer setCurrentTime:0];
        [self.audioPlayer play];
    }];
    
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
        [PictureManager sharedManager].isSlide = YES;
        [self dismissViewControllerAnimated:NO completion:nil];
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
    } else {
        imageView.image = [UIImage imageWithContentsOfFile:[slideShowImages objectAtIndex:currentImageIndex-1]];
        imageView.hidden = NO;
    }
    
//    if (currentImageIndex == 1) {
//        if (self.audioPlayer.playing) {
//            [self.audioPlayer stop];
//        }
//        [self.audioPlayer setCurrentTime:0];
//        [self.audioPlayer play];
//    }
    
    imageView.alpha = 1;
    moveView.frame = CGRectMake(0, 0, 1, 1);
    [UIView animateWithDuration:1.0f animations:^{
        moveView.frame = CGRectMake(0, 1, 1, 1);
    } completion:^(BOOL finished){
        imageView.alpha = 0;
        int end;
        if ([PictureManager sharedManager].isNameMode) {
            end = 20;
        } else {
            end = 21;
        }
        if (currentImageIndex < end) {
            if (self.audioPlayer.playing) {
                [self.audioPlayer stop];
            }
            [self.audioPlayer setCurrentTime:0];
            [self.audioPlayer play];
        }
    }];
    
    //最後の画像になったらIDをリセットする
    if ([self isLastImage]) {
        [self performSelector:@selector(stop) withObject:nil afterDelay:1.05];
    }
    
//    [self animation:imageView];
}

-(void)stop {
    //        currentImageIndex = -1;
    [self stopSlideShow];
    [PictureManager sharedManager].isSlide = YES;
    [self dismissViewControllerAnimated:NO completion:nil];
    return;
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

-(void)animation: (UIView *) view {
    //なにがしかのUIViewからlayerを取得
    CALayer *layer = view.layer;
    
    //CABasicAnimationオブジェクトを生成
    //サンプルでは"position"をアニメーションさせる例。
    //他に、transformを変更したい場合は@"transform.translate.x"などと指定する
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    //アニメーション時間
    animation.duration = slideShowTimerInterval;
    //アニメーションの繰り返し回数
    animation.repeatCount = MAXFLOAT;
    //アニメーションの開始時間
    animation.beginTime = CACurrentMediaTime(); //開始時間
    
    //アニメーション終了時に、逆方向にもアニメーションさせるか
    animation.autoreverses = NO; //YESにした場合はアニメーションが往復する
    
    //アニメーションのイージングを制御
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // 拡大・縮小倍率を設定
    animation.fromValue = [NSNumber numberWithFloat:0.9]; // 開始時の倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 終了時の倍率
    
    //アニメーション終了時、元の状態に戻すか否かの設定（サンプルではアニメーション後はそのまま）
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    //アニメーションキーを設定（任意の名前）
    [layer addAnimation:animation forKey:@"animation"];
}

-(void)start {
    startButton.enabled = NO;
    //スライドショー開始
    [self startSlideShow];
}

@end
