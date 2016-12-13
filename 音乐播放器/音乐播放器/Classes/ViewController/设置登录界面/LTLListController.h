//
//  LTLListController.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/9.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM( NSUInteger,LTLListType)
{
    LTLListTypeHistoryList = 0,
    LTLListTypeLikeList,
    LTLListTypeDownloaTrack ,
   
};


@interface LTLListController : UITableViewController

@property (nonatomic,assign,getter=isListType) LTLListType listType;

@end
