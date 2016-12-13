//
//  LTLThemeManager.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/26.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLThemeManager.h"

@implementation LTLThemeManager
#pragma mark - 单例
//单例
+ (instancetype)sharedManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
-(UIColor *)themeColor
{
    if (!_themeColor)
    {
        _themeColor = [UIColor blueColor];
    }
    return _themeColor;
}
@end
