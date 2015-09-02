//
//  PictureManager.m
//  Picture21
//
//  Created by 于　超 on 2015/08/29.
//  Copyright (c) 2015年 semler. All rights reserved.
//

#import "PictureManager.h"

@implementation PictureManager

static PictureManager *manager = nil;

+ (PictureManager *)sharedManager{
    if (!manager) {
        manager = [[PictureManager alloc] init];
    }
    return manager;
}

- (id)init
{
    
    return self;
}



@end
