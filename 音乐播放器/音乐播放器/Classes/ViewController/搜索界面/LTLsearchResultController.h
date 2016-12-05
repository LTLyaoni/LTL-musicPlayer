//
//  LTLsearchResultController.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/29.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^scroll)();
@interface LTLsearchResultController : UIViewController
///滑动时调用
@property (nonatomic, copy) scroll scroll;
//搜索词
@property (nonatomic,strong) NSString *searchText;


@end
