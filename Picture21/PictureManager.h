//
//  PictureManager.h
//  Picture21
//
//  Created by 于　超 on 2015/08/29.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureManager : NSObject

+ (PictureManager *)sharedManager;

@property (nonatomic) BOOL isNameMode; // 20枚、21枚
@property (nonatomic) BOOL isSlide;

@end
