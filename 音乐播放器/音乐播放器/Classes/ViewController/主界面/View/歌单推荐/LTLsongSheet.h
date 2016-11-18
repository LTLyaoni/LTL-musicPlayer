//
//  LTLsongSheet.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTLSongViewController.h"
@class LTLsongSheet;

@protocol LTLsongSheetDelegate <NSObject>

-(void)LTLsongSheet:(LTLsongSheet *)song VC : (LTLSongViewController *)SongViewController;

@end

@interface LTLsongSheet : UICollectionView

///代理
@property (nonatomic,weak) id<LTLsongSheetDelegate>LTLDelegate;
///初始化函数
+(LTLsongSheet *)initSongSheet;
@end
