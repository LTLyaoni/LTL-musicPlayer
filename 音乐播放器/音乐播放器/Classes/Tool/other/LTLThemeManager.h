//
//  LTLThemeManager.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/26.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTLThemeManager : NSObject

@property (nonatomic,strong) UIColor *themeColor;

//单例
+ (instancetype)sharedManager;
@end
