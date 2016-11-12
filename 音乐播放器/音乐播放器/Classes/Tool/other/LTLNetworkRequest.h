//
//  LTLNetworkRequest.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/29.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTLNetworkEnum.h"
@class XMErrorModel;
///数据返回函数块
typedef void (^LTL)(NSMutableArray * _Nullable modelArray , XMErrorModel   * _Nullable error);

@interface LTLNetworkRequest : NSObject
/**
 获取分类推荐的焦点图列表数据

 @param LTL 数据详情
 */
+(void)CategoryBanner:( LTL _Nullable)LTL;

/**
 获取歌单
 
 @param page 请求的页数
 @param dimension 维度
 @param LTL 数据返回
 */
+(void)MetadataAlbumsPage:(NSInteger )page dimension: (LTLDimension)dimension dadt:( LTL _Nullable )LTL;
#pragma mark - 获取分类推荐
+(void)RecommendAlbums:( LTL _Nullable )LTL;
@end
